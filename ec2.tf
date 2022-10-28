resource "aws_instance" "webinstance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "airbnb-webserver"
  }
}