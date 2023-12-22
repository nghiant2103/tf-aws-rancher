# Create the Security Group
resource "aws_security_group" "security_group_ec2" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.project_name}-${var.environment}-sg-ec2"
  description = "EC2 Security Group"

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allow_cidr_block_ssh
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allow_cidr_block_ssh
  }

  dynamic "ingress" {
    for_each = var.web_traffic_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allow_cidr_block_web_traffic
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
