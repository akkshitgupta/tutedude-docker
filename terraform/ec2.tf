# Common Instance Configuration
resource "aws_instance" "part-1-common-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name     = var.key_name
  security_groups = ["launch-wizard-1"]

  tags = {
    Name = "TutuDude-EC2"
  }
}

# Separate EC2 Instances for Flask and Express Applications
resource "aws_instance" "flask" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.part-2-subnet-public.id
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  tags = {
    Name = "Flask-EC2"
  }
}


resource "aws_instance" "express" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.part-2-subnet-public.id
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.express_sg.id]

  tags = {
    Name = "Express-EC2"
  }
}
