# ------------------------------- Definitions ---------------------------------
locals {
  groups = {
    admins     = ["admin"]
    developers = ["dev1", "dev2"]
  }
}

# ---------------------------------- Users ------------------------------------
resource "aws_iam_user" "users" {
  for_each = toset(concat(local.groups.admins, local.groups.developers))
  name     = each.key
  tags     = var.tags
}

resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users
  user     = each.key
}

output "users_passwords" {
  value = { for k, v in aws_iam_user_login_profile.users : k => v.password }
}

# --------------------------------- Groups -----------------------------------
resource "aws_iam_group" "groups" {
  for_each = local.groups
  name     = each.key
}

# ---------------------------- Group Membership ------------------------------
resource "aws_iam_group_membership" "admins" {
  name  = "admins_membership"
  users = toset(local.groups.admins)
  group = aws_iam_group.groups["admins"].name
}

resource "aws_iam_group_membership" "developers" {
  name  = "developers_membership"
  users = toset(local.groups.developers)
  group = aws_iam_group.groups["developers"].name
}

