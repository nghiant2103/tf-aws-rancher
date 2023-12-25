locals {
  key_name = "${var.project_name}-${var.environment}-key-pair"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = local.key_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "null_resource" "save_local_key" {
  provisioner "local-exec" {
    command = <<-EOT
      [ -f "./${local.key_name}.pem" ] && rm ./${local.key_name}.pem
      echo "${tls_private_key.key.private_key_pem}" > ./${local.key_name}.pem
      chmod 400 ./${local.key_name}.pem
    EOT
  }

  triggers = {
    "key" = tls_private_key.key.private_key_pem
  }

  depends_on = [aws_key_pair.generated_key]
}
