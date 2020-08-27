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
| terraform | >= 0.12.19 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tags | User-Defined tags | `map(string)` | `{}` | no |
| allowed\_cidrs | List of CIDRs permitted to access EFS mounts | `list(string)` | `[]` | no |
| allowed\_security\_groups | List of Security Group IDs permitted to access EFS mounts | `list(string)` | `[]` | no |
| backup\_kms\_key\_id | KMS Key to use for backups (Specify `aws/backup` to use the default key, leave null to have a key generated automatically) | `string` | `null` | no |
| backup\_schedule | Cron schedule to run backups on | `string` | `"cron(0 0 * * ? *)"` | no |
| create | If `false`, this module does nothing | `bool` | `true` | no |
| efs\_kms\_key\_id | ARN of KMS key to use for EFS encryption (leave null to create a key, set to `aws/backup` to use AWS default CMK) | `string` | `null` | no |
| enable\_backups | Should AWS Backup be configured for this file system? | `bool` | `true` | no |
| name | Moniker to apply/prefix to all resources in the module (required if `create==true`) | `string` | `null` | no |
| performance\_mode | Performance mode to run in (`generalPurpose` or `maxIO`). See https://aws.amazon.com/premiumsupport/knowledge-center/linux-efs-performance-modes/ for details. | `string` | `"generalPurpose"` | no |
| provisioned\_throughput | Provisioned throughput (in mbps) | `number` | `null` | no |
| subnets | Subnet IDs that the EFS mount points should be created on (required if `create==true`) | `list(string)` | `[]` | no |
| throughput\_mode | EFS file system throughput mode (`provisioned` or `bursting`) | `string` | `"bursting"` | no |
| vpc\_id | VPC to create EFS file system in (required if `create==true`) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| efs\_file\_system\_id | EFS File System ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
