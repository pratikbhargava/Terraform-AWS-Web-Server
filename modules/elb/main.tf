resource "aws_elb" "web_server_elb" {
  count = var.create_elb ? 1 : 0

  name = var.name

  subnets         = var.subnets
  internal        = var.internal
  security_groups = var.security_groups

  cross_zone_load_balancing = var.cross_zone_load_balancing
  idle_timeout              = var.idle_timeout

  dynamic "listener" {
    for_each = var.listener
    content {
      instance_port      = listener.value.instance_port
      instance_protocol  = listener.value.instance_protocol
      lb_port            = listener.value.lb_port
      lb_protocol        = listener.value.lb_protocol
      ssl_certificate_id = lookup(listener.value, "ssl_certificate_id", null)
    }
  }

  health_check {
    healthy_threshold   = lookup(var.health_check, "healthy_threshold")
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
    target              = lookup(var.health_check, "target")
    interval            = lookup(var.health_check, "interval")
    timeout             = lookup(var.health_check, "timeout")
  }

  tags = {
    "Name" = format("%s", var.name)
  }
}

resource "aws_elb_attachment" "ec2_elb_att" {
  #count = var.create_elb || var.create_attachment ? length(var.instances) : 0
  count = var.create_elb || var.create_attachment ? var.number_of_instances : 0

  elb      = var.create_elb ? aws_elb.web_server_elb[0].id : var.elb
  instance = element(var.instances, count.index)
}
