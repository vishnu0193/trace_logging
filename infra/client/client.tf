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

data "aws_ssm_parameter" "db_pass" {
  name = "/db/pass"
}

resource "aws_instance" "clientserver" {
  count = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key_name
  tags = {
    Name = "AlphaClients"
  }
  user_data = data.template_file.ssh_data.rendered
}


data "template_file" "ssh_data" {
  template = file("${path.module}/../../src/user_data.sh")
  vars = {
  ansible_user_pass = data.aws_ssm_parameter.db_pass.value
  }
}

