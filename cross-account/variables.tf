variable "project_name" {
  type    = string
  default = "aws-solutions-architect"
}

variable "application" {
  type    = string
  default = "cross-account"
}

variable "tags" {
  type = object({ project = string })
  default = {
    project     = "aws-solutions-architect"
    application = "cross-account"
  }
}

variable "id_account_a" {
  type    = string
}

variable "id_account_b" {
  type    = string
}
