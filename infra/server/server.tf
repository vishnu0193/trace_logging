data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["538418621991"] # Canonical
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "AlphaServer"
  }
}
resource "random_string" "db_pass" {
  length = 10
}
data "template_file" "tracing_data" {
  template = file("${path.module}/../../src/db_server.sh")
  vars = {
    DB_HOST = aws_instance.webserver.associate_public_ip_address
    DB_PASSWORD = random_string.db_pass.result
    DB_PORT = "5432"
    DB_NAME = "ssh_logging"
    DB_USER = "postgres"
  }
}