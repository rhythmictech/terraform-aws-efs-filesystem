locals {
  create_cidr_rule = var.create && length(var.allowed_cidrs) > 0 ? true : false
  create_sg_rule   = var.create && length(var.allowed_security_groups) > 0 ? true : false
}

resource "aws_security_group" "this" {
  count = var.create ? 1 : 0

  name_prefix = var.name
  description = "SG for access to ${var.name} file system"
  tags        = var.additional_tags
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_sgs_to_efs" {
  count = local.create_sg_rule ? length(var.allowed_security_groups) : 0

  description              = "SG ${var.allowed_security_groups[count.index]} permitted access to EFS mounts"
  from_port                = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this[0].id
  source_security_group_id = var.allowed_security_groups[count.index]
  to_port                  = 2049
  type                     = "ingress"
}

resource "aws_security_group_rule" "allow_cidrs_to_efs" {
  count = local.create_cidr_rule ? 1 : 0

  cidr_blocks       = var.allowed_cidrs
  description       = "CIDRs permitted access to EFS mounts"
  from_port         = 2049
  protocol          = "tcp"
  security_group_id = aws_security_group.this[0].id
  to_port           = 2049
  type              = "ingress"
}

resource "aws_efs_file_system" "this" {
  count = var.create ? 1 : 0

  encrypted                       = true
  kms_key_id                      = var.efs_kms_key_id
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.throughput_mode == "provisioned" ? var.provisioned_throughput : null
  tags                            = var.additional_tags
  throughput_mode                 = var.throughput_mode
}

resource "aws_efs_mount_target" "this" {
  count = var.create ? length(var.subnets) : 0

  file_system_id  = aws_efs_file_system.this[0].id
  security_groups = [aws_security_group.this[0].id]
  subnet_id       = var.subnets[count.index]
}
