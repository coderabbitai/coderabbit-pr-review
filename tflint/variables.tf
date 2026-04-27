variable "environment" {
  default = "production"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "admin_email" {
}

variable "unused_legacy_setting" {
  type        = string
  description = "Legacy toggle retained during migration. Not currently consumed."
  default     = "off"
}

variable "tags" {
  default = {
    Project = "demoapp"
    Owner   = "platform-team"
  }
}

variable "subnets" {
  default = []
}

locals {
  computed_name = "demoapp-${var.environment}"
  unused_local  = "this local is never referenced anywhere"
}
