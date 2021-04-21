
output "efs_file_system_id" {
  description = "EFS File System ID"
  value       = try(aws_efs_file_system.this[0].id, "")
}

output "efs_backup_iam_role" {
  description = "Name of the IAM Role created to run AWS Backup"
  value       = try(aws_iam_role.backup[0].id, null)
}
