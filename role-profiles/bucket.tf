resource "random_id" "_" {
  byte_length = 8
}

resource "aws_s3_bucket" "appconfig" {
  bucket = "${random_id._.hex}-appconfig"
  tags   = var.tags
}

resource "aws_s3_bucket" "customerdata" {
  bucket = "${random_id._.hex}-customerdata"
  tags   = var.tags
}
