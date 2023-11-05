terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      environment = var.environment
      application = var.application_tag_name
    }
  }
}
  