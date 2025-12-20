# Part 2 Security Groups for EC2 Instances
# Separate security groups for Flask and Express applications
# create security groups
resource "aws_security_group" "flask_sg" {
  name   = "flask-sg"
  vpc_id = aws_vpc.part-2-vpc.id
}

resource "aws_security_group" "express_sg" {
  name   = "express-sg"
  vpc_id = aws_vpc.part-2-vpc.id
}

# create security group rules for SSH access
resource "aws_security_group_rule" "flask_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flask_sg.id
}

resource "aws_security_group_rule" "express_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.express_sg.id
}

# create security group rules for public access
resource "aws_security_group_rule" "flask_public" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flask_sg.id
}

resource "aws_security_group_rule" "express_public" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.express_sg.id
}

# create security group rules for inter-service communication
resource "aws_security_group_rule" "flask_from_express" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.flask_sg.id
  source_security_group_id = aws_security_group.express_sg.id
}

resource "aws_security_group_rule" "express_from_flask" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.express_sg.id
  source_security_group_id = aws_security_group.flask_sg.id
}

resource "aws_security_group_rule" "flask_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flask_sg.id
}

resource "aws_security_group_rule" "express_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.express_sg.id
}


# Part 3 Security Groups for ECS Tasks
resource "aws_security_group" "part-3-alb_sg" {
  vpc_id = aws_vpc.part-3-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.part-3-vpc.id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.part-3-alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

