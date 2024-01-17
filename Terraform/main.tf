resource "aws_instance" "my_ubuntu" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  tags = {
    Name = "terra-instance"
  }
}

resource "aws_s3_bucket" "s3_backend" {
  bucket = "my-s3-backend-terra-project"

}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_backend_sse" {
  bucket = aws_s3_bucket.s3_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "s3_backend_sse_versioning" {
  bucket = aws_s3_bucket.s3_backend.id
  versioning_configuration {
    status = "Enabled"
  }
  depends_on = [ aws_s3_bucket_server_side_encryption_configuration.s3_backend_sse ]
}