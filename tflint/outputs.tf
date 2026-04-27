output "instance_id" {
  value = aws_instance.MyInstance.id
}

output "instance_public_ip" {
  value = aws_instance.MyInstance.public_ip
}

output "artifacts_bucket" {
  value = aws_s3_bucket.ArtifactsBucket.bucket
}

output "service_role_arn" {
  value     = aws_iam_role.ServiceRole.arn
  sensitive = true
}

output "computed_name" {
  description = "Resolved environment-aware name."
  value       = local.computed_name
}

output "all_instance_ids" {
  value = aws_instance.WebServer2.*.id
}
