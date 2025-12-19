output "part-1-instance-public-ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.instance-example-1.public_ip
}
