resource "aws_s3_bucket" "investing_bucket" {
  bucket = "ortisan-investing-data-bucket"
  acl    = "private"
  tags = {
    Name        = "Glue Testing Demo Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "stocks" {
  for_each = fileset("${path.module}/s3-files/stocks/", "*")
  bucket = aws_s3_bucket.investing_bucket.id
  key = "stocks/${each.value}"
  source = "s3-files/stocks/${each.value}"
  etag = filemd5("${path.module}/s3-files/stocks/${each.value}")
}