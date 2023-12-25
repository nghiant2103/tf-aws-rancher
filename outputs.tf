output "server_ip" {
  value = aws_instance.server.public_ip
}

output "private_key_pem" {
  sensitive = true
  value     = tls_private_key.key.private_key_pem
}
