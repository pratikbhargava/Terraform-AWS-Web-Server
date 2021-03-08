locals {
  nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(data.aws_availability_zones.all.names) : length(var.private_subnets)
}

data "aws_availability_zones" "all" {
  state = "available"
}


######
# VPC
######
resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = "default"

  tags = {
    "Name" = format("%s-vpc", var.name)
  }
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = {
    "Name" = format("%s -igw", var.name)
  }
}

################
# Publiс routes
################
resource "aws_route_table" "public_rtb" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id = aws_vpc.this[0].id

  tags = {
    "Name" = format("%s-public-%s-rtb", var.name, element(data.aws_availability_zones.all.names, count.index))
  }

}

resource "aws_route" "public_igw" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  //route_table_id         = aws_route_table.public_rtb[count.index].id
  route_table_id         = element(aws_route_table.public_rtb.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

#################
# Private routes
# There are as many routing tables as the number of NAT gateways
#################
resource "aws_route_table" "private_rtb" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? local.nat_gateway_count : 0

  vpc_id = aws_vpc.this[0].id

  tags = {
    "Name" = var.single_nat_gateway ? "%s-private-rtb" : format(
      "%s-private-%s-rtb",
      var.name,
      element(data.aws_availability_zones.all.names, count.index),
    )
  }
}

################
# Public subnet
################
resource "aws_subnet" "public_subnets" {
  count = var.create_vpc && length(var.public_subnets) > 0 && (false == var.one_nat_gateway_per_az || length(var.public_subnets) >= length(data.aws_availability_zones.all.names)) ? length(var.public_subnets) : 0

  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = element(concat(var.public_subnets, [""]), count.index)
  availability_zone       = length(regexall("^[a-z]{2}-", element(data.aws_availability_zones.all.names, count.index))) > 0 ? element(data.aws_availability_zones.all.names, count.index) : null
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    "Name" = format(
      "%s-public-subnet-%s",
      var.name,
      element(data.aws_availability_zones.all.names, count.index),
    )
  }
}

#################
# Private subnet
#################
resource "aws_subnet" "private_subnets" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(data.aws_availability_zones.all.names, count.index))) > 0 ? element(data.aws_availability_zones.all.names, count.index) : null

  tags = {
    "Name" = format(
      "%s-private-subnet-%s",
      var.name,
      element(data.aws_availability_zones.all.names, count.index),
    )
  }
}

##############
# NAT Gateway
##############
resource "aws_eip" "nat" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  vpc = true

  tags = {
    "Name" = format(
      "%s-eip%s",
      var.name,
      element(data.aws_availability_zones.all.names, var.single_nat_gateway ? 0 : count.index),
    )
  }
}


resource "aws_nat_gateway" "this" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  allocation_id = element(split(
    ",",
    join(",", aws_eip.nat.*.id)),
    var.single_nat_gateway ? 0 : count.index,
  )
  subnet_id = element(
    aws_subnet.public_subnets.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )

  tags = {
    "Name" = format(
      "%s-%s",
      var.name,
      element(var.azs, var.single_nat_gateway ? 0 : count.index),
    )
  }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route" "private_nat_gateway" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  route_table_id         = element(aws_route_table.private_rtb.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)

  timeouts {
    create = "5m"
  }
}

##########################
# Route table association
##########################
resource "aws_route_table_association" "private_rta" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(
    aws_route_table.private_rtb.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
}

resource "aws_route_table_association" "public_rta" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_rtb.*.id, count.index)
}
