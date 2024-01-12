data "aws_ami" "amzn_ubuntu_22_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "server" {
  ami                         = data.aws_ami.amzn_ubuntu_22_ami.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet_01.id
  vpc_security_group_ids      = [aws_security_group.security_group_ec2.id]
  associate_public_ip_address = true
  key_name                    = local.key_name
  iam_instance_profile        = aws_iam_instance_profile.iam_instance_profile.name
  user_data_replace_on_change = true
  user_data                   = file("./user_data.sh")

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-server"
    env  = var.environment
  }

  depends_on = [aws_key_pair.generated_key]
}

resource "null_resource" "update_ssh_file" {
  provisioner "local-exec" {
    command = <<-EOT
      sed -i "s/ssh.*/ssh ubuntu@${aws_instance.server.public_ip} -i .\/${local.key_name}.pem/g" ./ssh.sh 
    EOT
  }

  triggers = {
    "key" = aws_instance.server.public_ip
  }

  depends_on = [aws_instance.server]
}
