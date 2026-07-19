output "private_instance_ip" {
  description = "Private IPv4 address of the EC2 instance in the private subnet"
  value       = aws_instance.private.private_ip
}

output "bastion_public_instance_ip" {
  description = "Public IPv4 address of the bastion host"
  value       = aws_instance.public.public_ip
}
