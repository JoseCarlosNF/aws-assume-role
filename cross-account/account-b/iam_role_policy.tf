# ---------------------------------- Role ------------------------------------
data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "AllowAssumeRole"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.id_account_a}:user/${var.application}-${var.project_name}"]
    }
  }
}

resource "aws_iam_role" "_" {
  name               = "${var.application}-${var.project_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

# -------------------------- Policy to access SQS ----------------------------
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "allow_send_message_sqs" {
  statement {
    sid       = "AllowSendMessageSQS"
    resources = ["arn:aws:sqs::${var.id_account_b}:${var.application}-${var.project_name}"]
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListQueues",
      "sqs:ListMessageMoveTasks",
      "sqs:SendMessage",
    ]
  }
}

resource "aws_iam_policy" "_" {
  name        = "${var.application}-${var.project_name}"
  description = "Mesmas permissões da policy gerenciada AmazonSQSReadOnlyAccess + sqs:SendMessage"
  policy      = data.aws_iam_policy_document.allow_send_message_sqs.json
}

# ------------------------ Policy attachment on Role -------------------------
resource "aws_iam_role_policy_attachment" "_" {
  policy_arn = aws_iam_policy._.arn
  role       = aws_iam_role._.name
}

