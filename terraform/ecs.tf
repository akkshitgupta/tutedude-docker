resource "aws_ecs_cluster" "flask-express-cluster" {
  name = "flask-express-cluster"
}

resource "aws_ecs_task_definition" "flask-def" {
  family                   = "flask-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_exec.arn

  container_definitions = jsonencode([
    {
      name  = "flask"
      image = "${aws_ecr_repository.flask.repository_url}:latest"
      portMappings = [{ containerPort = 8000 }]
    }
  ])
}

resource "aws_ecs_task_definition" "express-def" {
  family                   = "express-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_exec.arn

  container_definitions = jsonencode([
    {
      name  = "express"
      image = "${aws_ecr_repository.express.repository_url}:latest"
      portMappings = [{ containerPort = 3000 }]
    }
  ])
}
