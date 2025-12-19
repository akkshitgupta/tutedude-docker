# create security groups
resource "aws_security_group" "flask_sg" {
  name   = "flask-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "express_sg" {
  name   = "express-sg"
  vpc_id = aws_vpc.main.id
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
