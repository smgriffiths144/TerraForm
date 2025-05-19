

output "secuirty_group_arn" {
  value = aws_security_group.secure1.arn // via local or just
  #value = data.aws_caller_identity.current.account_id
}