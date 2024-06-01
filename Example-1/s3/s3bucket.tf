provider "aws" {
    region = "eu-east-1"
}

resource "aws_s3_bucket" "example_bucket" {
    bucket = "my-first-bucket"
    
    versioning {
      enabled = true
    }
}
