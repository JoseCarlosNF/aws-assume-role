resource "aws_sqs_queue" "_" {
  name   = "${var.application}-${var.project_name}"
  policy = data.aws_iam_policy_document.allow_role_access_sqs.json
  tags   = var.tags
}

data "aws_region" "current" {}
data "aws_iam_policy_document" "allow_role_access_sqs" {
  statement {
    sid       = "AllowRoleAccessSQS"
    actions   = ["sqs:*"]
    resources = ["arn:aws:sqs:${data.aws_region.current.id}:${var.id_account_b}:${var.application}-${var.project_name}"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
