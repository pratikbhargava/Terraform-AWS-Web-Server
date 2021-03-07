terraform {
  backend "s3" {
    bucket         = "al0l-tfstate"
    key            = "websg/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "al0l-state-lock"
  }
}

provider "aws" {
  region = var.region
}
