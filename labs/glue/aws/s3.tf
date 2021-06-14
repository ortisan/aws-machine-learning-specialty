resource "aws_s3_bucket" "mls_c01_data" {
  bucket = "mls-c01-labs-data-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
  tags = {
    Name        = "Glue Data Bucket Demo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "mls_c01_stocks_data" {
  for_each = fileset("${path.module}/s3-files/stocks/", "*")
  bucket = aws_s3_bucket.mls_c01_data.id
  key = "stocks/${each.value}"
  source = "s3-files/stocks/${each.value}"
  etag = filemd5("${path.module}/s3-files/stocks/${each.value}")
}

resource "aws_s3_bucket" "mls_c01_glue_scripts" {
  bucket = "mls-c01-labs-glue-scripts-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
  tags = {
    Name        = "Glue Scripts Bucket for Demo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "mls_c01_glue_scripts" {
  for_each = fileset("${path.module}/s3-files/job_scripts/", "*")
  bucket = aws_s3_bucket.mls_c01_glue_scripts.id
  key = "${each.value}"
  source = "s3-files/job_scripts/${each.value}"
  etag = filemd5("${path.module}/job_scripts/${each.value}")
}

resource "aws_s3_bucket" "mls_c01_glue_temporary" {
  bucket = "mls-c01-labs-glue-temporary-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
  tags = {
    Name        = "Glue Temporary Bucket for Demo"
    Environment = "Dev"
  }
}