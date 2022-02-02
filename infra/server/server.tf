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

  owners = ["099720109477"]  # Canonical
}

resource "random_string" "db_pass" {
  length = 10
}



resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key_name
  tags = {
    Name = "AlphaServer"
  }
  user_data = data.template_file.tracing_data.rendered
}

data "template_file" "tracing_data" {
  template = file("${path.module}/../../src/db_server.sh")
  vars = {
    DB_PASSWORD = random_string.db_pass.result
    DB_NAME = "ssh_logging"
    DB_USER = "postgres"
  }
}
