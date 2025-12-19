output "common-public-ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.instance-example-1.public_ip
}

output "flask_public_ip" {
  value = aws_instance.flask.public_ip
}

output "express_public_ip" {
  value = aws_instance.express.public_ip
}

output "flask_private_ip" {
  value = aws_instance.flask.private_ip
}

output "express_private_ip" {
  value = aws_instance.express.private_ip
}

