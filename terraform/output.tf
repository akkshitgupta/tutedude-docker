output "instance_public_ip-1" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.instance-example-1.public_ip
}

output "instance_public_ip-2" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.instance-example-2.public_ip
}
