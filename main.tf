provider "aws" {
  region = var.region
}

# Security Group for the EC2 instances
resource "aws_security_group" "project_sg" {
  name        = var.security_group_name
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH access from anywhere (use cautiously)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id
}

# Launch Template
resource "aws_launch_template" "project_template" {
  name          = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name


  network_interfaces {
    security_groups = [aws_security_group.project_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "project-instance"
    }
  }
}

# Application Load Balancer
resource "aws_lb" "project_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project_alb_sg.id]
  subnets            = var.subnets

  tags = {
    Name = "web-alb"
  }
}

# Security Group for the Load Balancer
resource "aws_security_group" "project_alb_sg" {
  name_prefix = "project-alb-sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Target Group for the Load Balancer
resource "aws_lb_target_group" "project_tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "project_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnets
  health_check_type    = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.project_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.project_tg.arn]

  tag {
    key                 = "Name"
    value               = "project-instance"
    propagate_at_launch = true
  }
}

