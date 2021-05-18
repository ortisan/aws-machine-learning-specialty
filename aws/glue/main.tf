provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "investing_bucket" {
  bucket = "ortisan-investing-data-bucket"
  acl    = "private"
  tags = {
    Name        = "Glue Testing Demo Bucket"
    Environment = "Dev"
    Environment = "demo"
  }
}

resource "aws_glue_catalog_database" "investing_catalog_database" {
  name = "investing-catalog-database"
}

resource "aws_iam_role" "glue_service_iam_role" {
  name = "glue-iam-role"

  assume_role_policy = jsonencode({

    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "glue:*",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:ListAllMyBuckets",
          "s3:GetBucketAcl",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeRouteTables",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcAttribute",
          "iam:ListRolePolicies",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "cloudwatch:PutMetricData"
        ],
        "Resource" = [
          "*"
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:CreateBucket"
        ],
        "Resource" = [
          "arn:aws:s3:::aws-glue-*"
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        "Resource" = [
          "arn:aws:s3:::aws-glue-*/*",
          "arn:aws:s3:::*/*aws-glue-*/*"
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:GetObject"
        ],
        "Resource" = [
          "arn:aws:s3:::crawler-public*",
          "arn:aws:s3:::aws-glue-*"
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:AssociateKmsKey"
        ],
        "Resource" = [
          "arn:aws:logs:*:*:/aws-glue/*"
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "ec2:CreateTags",
          "ec2:DeleteTags"
        ],
        "Condition" = {
          "ForAllValues:StringEquals" = {
            "aws:TagKeys" = [
              "aws-glue-service-resource"
            ]
          }
        },
        "Resource" = [
          "arn:aws:ec2:*:*:network-interface/*",
          "arn:aws:ec2:*:*:security-group/*",
          "arn:aws:ec2:*:*:instance/*"
        ]
      }
    ]
    }
  )

  tags = {
    name = "glue-iam-role-service"
  }
}

resource "aws_glue_crawler" "stocks_crawler" {
  database_name = aws_glue_catalog_database.investing_catalog_database.name
  name          = "stocks-crawler"
  role          = aws_iam_role.glue_service_iam_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.investing_bucket.bucket}/stocks"
  }
}