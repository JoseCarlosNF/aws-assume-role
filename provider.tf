terraform {
  required_providers {
    aws    = { source = "hashicorp/aws", version = "~>4.67.0" }
    random = { source = "hashicorp/random", version = "3.5.1" }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "aws-solutions-architect"
}

variable "tags" {
  type    = object({ project = string })
  default = { project = "aws-solutions-architect" }
}
