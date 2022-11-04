resource "aws_instance" "webinstance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  monitoring = true
  root_block_device {
    encrypted = true
    
  }

  tags = {
    Name = "airbnb-appserver-instance"
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "herry-451987"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
