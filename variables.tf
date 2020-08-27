########################################
# General Vars
########################################

variable "additional_tags" {
  default     = {}
  description = "User-Defined tags"
  type        = map(string)
}

variable "create" {
  default     = true
  description = "If `false`, this module does nothing"
  type        = bool
}

variable "name" {
  default     = null
  description = "Moniker to apply/prefix to all resources in the module (required if `create==true`)"
  type        = string
}

variable "efs_kms_key_id" {
  default     = null
  description = "ARN of KMS key to use for EFS encryption (leave null to create a key, set to `aws/backup` to use AWS default CMK)"
  type        = string
}

variable "performance_mode" {
  default     = "generalPurpose"
  description = "Performance mode to run in (`generalPurpose` or `maxIO`). See https://aws.amazon.com/premiumsupport/knowledge-center/linux-efs-performance-modes/ for details."
  type        = string
}

variable "provisioned_throughput" {
  default     = null
  description = "Provisioned throughput (in mbps)"
  type        = number
}

variable "throughput_mode" {
  default     = "bursting"
  description = "EFS file system throughput mode (`provisioned` or `bursting`)"
  type        = string
}

########################################
# Networking Vars
########################################

variable "allowed_cidrs" {
  default     = []
  description = "List of CIDRs permitted to access EFS mounts"
  type        = list(string)
}

variable "allowed_security_groups" {
  default     = []
  description = "List of Security Group IDs permitted to access EFS mounts"
  type        = list(string)
}

variable "subnets" {
  default     = []
  description = "Subnet IDs that the EFS mount points should be created on (required if `create==true`)"
  type        = list(string)
}

variable "vpc_id" {
  default     = null
  description = "VPC to create EFS file system in (required if `create==true`)"
  type        = string
}

########################################
# Backup Vars
########################################

variable "backup_kms_key_id" {
  default     = null
  description = "KMS Key to use for backups (Specify `aws/backup` to use the default key, leave null to have a key generated automatically)"
  type        = string
}

variable "backup_schedule" {
  default     = "cron(0 0 * * ? *)"
  description = "Cron schedule to run backups on"
  type        = string
}

variable "enable_backups" {
  default     = true
  description = "Should AWS Backup be configured for this file system?"
  type        = bool
}
