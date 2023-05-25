# -------------------------------- Policies ----------------------------------
resource "aws_iam_policy" "AppConfig" {
  name        = "S3AppConfig"
  description = "Define policies to access appconfig bucket."
  tags        = var.tags
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ListAllBuckets"
        Effect   = "Allow"
        Action   = ["s3:ListAllMyBuckets"]
        Resource = ["arn:aws:s3:::*"]
      },
      {
        Sid    = "AllowAccessObjects"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
        ]
        Resource = [
          aws_s3_bucket.appconfig.arn,
          "${aws_s3_bucket.appconfig.arn}/*",
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "CustomerData" {
  name        = "S3CustomerData"
  description = "Define policies to access customerdata bucket."
  tags        = var.tags
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ListAllBuckets"
        Effect   = "Allow"
        Action   = ["s3:ListAllMyBuckets"]
        Resource = ["arn:aws:s3:::*"]
      },
      {
        Sid    = "AllowAccessObjects"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
        ]
        Resource = [
          aws_s3_bucket.customerdata.arn,
          "${aws_s3_bucket.customerdata.arn}/*",
        ]
      }
    ]
  })
}

# ---------------------------------- Roles ------------------------------------
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "S3Developers" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = concat(
        [data.aws_caller_identity.current.account_id],
        local.arn_users_by_group["developers"],
      )
    }
  }
}

data "aws_iam_policy_document" "S3Admins" {
  statement {
    sid     = "AllowAdminsAccessS3CustomerData"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = concat(
        [data.aws_caller_identity.current.account_id],
        local.arn_users_by_group["admins"],
      )
    }
  }
}

resource "aws_iam_role" "S3Developers" {
  name               = "S3Developers"
  tags               = var.tags
  assume_role_policy = data.aws_iam_policy_document.S3Developers.json
}

resource "aws_iam_role" "S3Admins" {
  name               = "S3Admins"
  tags               = var.tags
  assume_role_policy = data.aws_iam_policy_document.S3Admins.json
}

output "roles" {
  value = {
    developers = aws_iam_role.S3Developers.name
    admins = aws_iam_role.S3Admins.name
  }
}

# ---------------------- Attachment Policies on Roles ------------------------
resource "aws_iam_role_policy_attachment" "S3Developers" {
  role       = aws_iam_role.S3Developers.name
  policy_arn = aws_iam_policy.AppConfig.arn
}

resource "aws_iam_role_policy_attachment" "S3AdminsAppConfig" {
  role       = aws_iam_role.S3Admins.name
  policy_arn = aws_iam_policy.AppConfig.arn
}

resource "aws_iam_role_policy_attachment" "S3AdminsCustomerData" {
  role       = aws_iam_role.S3Admins.name
  policy_arn = aws_iam_policy.CustomerData.arn
}
