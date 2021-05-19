provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_glue_catalog_database" "mls_c01_labs_catalog_database" {
  name = "mls-c01-labs-catalog-database"
}

resource "aws_glue_crawler" "stocks_crawler" {
  database_name = aws_glue_catalog_database.mls_c01_labs_catalog_database.name
  name          = "mls-c01-labs-stocks-crawler"
  role          = aws_iam_role.glue_service_iam_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.mls_c01_data.bucket}/stocks"
  }
}