

output "secuirty_group_arn" {
  value = aws_security_group.secure1.arn // via local or just
  #value = data.aws_caller_identity.current.account_id
}
/*
output "cloudwatch_log_group_name" {
  description = "Name (id) of the cloudwatch log group"
  value       = module.s3_bucket_remote_module.cloudwatch_log_group_name
}
*/