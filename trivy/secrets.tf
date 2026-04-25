provider "aws" {
  alias      = "deploy"
  region     = "us-west-2"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_ssm_parameter" "datadog_key" {
  name  = "/demoapp/observability/datadog_api_key"
  type  = "String"
  value = "1234567890abcdef1234567890abcdef"
}

resource "aws_ssm_parameter" "internal_token" {
  name  = "/demoapp/internal/service_token"
  type  = "String"
  value = "internal_token_2c8b41d9c0a64e1e9b0f3e7a1d5c8b41"
}

resource "aws_db_instance_password" "fallback" {
  password = "Sup3rS3cr3tP@ssword"
}
