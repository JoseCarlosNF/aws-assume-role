# ---------------------------------- User ------------------------------------
resource "aws_iam_user" "_" {
  name = "${var.application}-${var.project_name}"
  tags = var.tags
}

resource "aws_iam_access_key" "_" {
  user = aws_iam_user._.name
}

output "iam_credentials" {
  sensitive = false
  value = {
    access_key = aws_iam_access_key._.id
    secret_key = nonsensitive(aws_iam_access_key._.secret)
  }
}

# -------------------------- Policy to access SQS ----------------------------
data "aws_iam_policy_document" "allow_assume_role" {
  statement {
    sid = "AllowAssumeRole"
    resources = [
      "arn:aws:iam::${var.id_account_b}:role/${var.application}-${var.project_name}",
    ]
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "_" {
  name        = "${var.application}-${var.project_name}"
  description = "Mesmas permissões da policy gerenciada AmazonSQSReadOnlyAccess + sqs:SendMessage"
  policy      = data.aws_iam_policy_document.allow_assume_role.json
}

# ------------------------ Policy attachment on User -------------------------
resource "aws_iam_policy_attachment" "_" {
  name       = "AllowSendMessageSQS"
  users      = [aws_iam_user._.name]
  policy_arn = aws_iam_policy._.arn

}

