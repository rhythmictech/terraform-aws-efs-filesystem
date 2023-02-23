# terraform-aws-efs-filesystem

Creates an AWS EFS file system and associated mount points and security group. Optionally (on by default), configures a one-off AWS Backup plan/vault to back up the volume.

[![tflint](https://github.com/rhythmictech/terraform-aws-efs-filesystem/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-efs-filesystem/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/terraform-aws-efs-filesystem/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-efs-filesystem/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-aws-efs-filesystem/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-efs-filesystem/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-aws-efs-filesystem/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-efs-filesystem/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-efs-filesystem/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-efs-filesystem/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

## Example

```hcl
module "efs" {
  source = "rhythmictech/efs-filesystem/aws"

  name                    = "photos"
  allowed_security_groups = ["sg-1234567890"]
  subnets                 = [
    "subnet-1234567890",
    "subnet-0123456789",
    "subnet-9012345678",
  ]
  vpc_id                  = "vpc-1234567890"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.19 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_efs_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_iam_role.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kms_key.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_cidrs_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_sgs_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.assume_backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | User-Defined tags | `map(string)` | `{}` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs permitted to access EFS mounts | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | List of Security Group IDs permitted to access EFS mounts | `list(string)` | `[]` | no |
| <a name="input_backup_kms_key_id"></a> [backup\_kms\_key\_id](#input\_backup\_kms\_key\_id) | KMS Key to use for backups (Specify `aws/backup` to use the default key, leave null to have a key generated automatically) | `string` | `null` | no |
| <a name="input_backup_lifecycle_cold_storage_after"></a> [backup\_lifecycle\_cold\_storage\_after](#input\_backup\_lifecycle\_cold\_storage\_after) | Specifies the number of days after creation that a recovery point is moved to cold storage. | `number` | `null` | no |
| <a name="input_backup_lifecycle_delete_after"></a> [backup\_lifecycle\_delete\_after](#input\_backup\_lifecycle\_delete\_after) | Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold\_storage\_after. | `number` | `null` | no |
| <a name="input_backup_role_permissions_boundary"></a> [backup\_role\_permissions\_boundary](#input\_backup\_role\_permissions\_boundary) | An optional IAM permissions boundary to use when creating the IAM role for backups | `string` | `null` | no |
| <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule) | Cron schedule to run backups on | `string` | `"cron(0 0 * * ? *)"` | no |
| <a name="input_create"></a> [create](#input\_create) | If `false`, this module does nothing | `bool` | `true` | no |
| <a name="input_efs_kms_key_id"></a> [efs\_kms\_key\_id](#input\_efs\_kms\_key\_id) | ARN of KMS key to use for EFS encryption (leave null to create a key, set to `aws/backup` to use AWS default CMK) | `string` | `null` | no |
| <a name="input_enable_backups"></a> [enable\_backups](#input\_enable\_backups) | Should AWS Backup be configured for this file system? | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Moniker to apply/prefix to all resources in the module (required if `create==true`) | `string` | `null` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | Performance mode to run in (`generalPurpose` or `maxIO`). See https://aws.amazon.com/premiumsupport/knowledge-center/linux-efs-performance-modes/ for details. | `string` | `"generalPurpose"` | no |
| <a name="input_provisioned_throughput"></a> [provisioned\_throughput](#input\_provisioned\_throughput) | Provisioned throughput (in mbps) | `number` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet IDs that the EFS mount points should be created on (required if `create==true`) | `list(string)` | `[]` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | EFS file system throughput mode (`provisioned` or `bursting`) | `string` | `"bursting"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC to create EFS file system in (required if `create==true`) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_backup_iam_role"></a> [efs\_backup\_iam\_role](#output\_efs\_backup\_iam\_role) | Name of the IAM Role created to run AWS Backup |
| <a name="output_efs_file_system_id"></a> [efs\_file\_system\_id](#output\_efs\_file\_system\_id) | EFS File System ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
