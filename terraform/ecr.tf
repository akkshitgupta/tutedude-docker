resource "aws_ecr_repository" "flask" {
  name = "td-flask-backend"
}

resource "aws_ecr_repository" "express" {
  name = "td-express-frontend"
}
