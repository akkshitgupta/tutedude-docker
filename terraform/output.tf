output "common-instance-ip" {
  description = "The public IP of the EC2 common instance"
  value       = aws_instance.part-1-common-instance.public_ip
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

output "flask_ecr_repo_url" {
  description = "The URL of the Flask ECR repository"
  value       = aws_ecr_repository.flask.repository_url
}
output "express_ecr_repo_url" {
  description = "The URL of the Express ECR repository"
  value       = aws_ecr_repository.express.repository_url
}

output "alb_dns_name" {
  description = "Public URL to access Flask and Express services"
  value       = aws_lb.alb.dns_name
}
