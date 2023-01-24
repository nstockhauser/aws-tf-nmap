###################### Good Guy Instance ###########################
resource "aws_instance" "good" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.lab-sg.id]
  private_ip             = "10.0.0.100"
  key_name               = "lab-key"

  user_data = <<EOF
#! /bin/bash
sudo apt-get update -y
sudo apt install nmap -y
sudo apt-get install nginx -y
sudo apt-get install vsftpd -y
EOF

  tags = {
    Name = "good"
  }

}


############################ Bad Guy instance ############################
resource "aws_instance" "bad" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.lab-sg.id]
  private_ip             = "10.0.0.200"
  key_name               = "lab-key"


  user_data = <<EOF
#! /bin/bash
sudo apt-get update -y
sudo apt install nmap -y
sudo apt install net-tools -y

EOF

  tags = {
    Name = "bad"
  }

}


####   SSH Keys and PEM File ########

resource "aws_key_pair" "deployer" {
  key_name   = "lab-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "test-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "test-key"

}

