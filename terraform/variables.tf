variable "aws_region" {
  description = "Region where sources allocated"
  default = "ap-south-1" 
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  default     = "tutedude-ec2"
}

variable "aws_access_key" {
  ephemeral = true
}

variable "aws_secret_key" {
  ephemeral = true
}