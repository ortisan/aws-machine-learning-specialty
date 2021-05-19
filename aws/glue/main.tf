provider "aws" {
  region = "us-east-1"
}

resource "aws_glue_catalog_database" "investing_catalog_database" {
  name = "investing-catalog-database"
}

resource "aws_glue_crawler" "stocks_crawler" {
  database_name = aws_glue_catalog_database.investing_catalog_database.name
  name          = "stocks-crawler"
  role          = aws_iam_role.glue_service_iam_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.investing_bucket.bucket}/stocks"
  }
}