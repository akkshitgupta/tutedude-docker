resource "aws_ecs_service" "flask" {
  name            = "flask-service"
  cluster         = aws_ecs_cluster.flask-express-cluster.id
  task_definition = aws_ecs_task_definition.flask-def.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = aws_subnet.part-3-subnet-public[*].id
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.flask.arn
    container_name   = "flask"
    container_port   = 8000
  }
}

resource "aws_ecs_service" "express" {
  name            = "express-service"
  cluster         = aws_ecs_cluster.flask-express-cluster.id
  task_definition = aws_ecs_task_definition.express-def.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = aws_subnet.part-3-subnet-public[*].id
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.express.arn
    container_name   = "express"
    container_port   = 3000
  }
}
