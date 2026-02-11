
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.region
}

module "vpc_n_ec2" {
  source           = "./modules/vpc_n_ec2"
  vpc_cidr         = "10.0.0.0/16"
  subnet_count     = 4
  instance_type    = "t3.micro"
  assign_public_ip = true
}

resource "aws_lb" "exam_alb" {
  name               = "exam-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc_n_ec2.subnets

  tags = {
    Name    = "Exam ALB"
    Created = "Terraform"
  }
}

resource "aws_lb_target_group" "exam_tg" {
  name     = "exam-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc_n_ec2.vpc_id

  health_check {
    path                = "/"
    interval            = 20
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.exam_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.exam_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "exam_attachment" {
  target_group_arn = aws_lb_target_group.exam_tg.arn
  target_id        = module.vpc_n_ec2.instances_ids
  port             = 80
}
# TODO: Configure auto-scaling with a minimum of 1 and a maximum of 3 instances.
# TODO:  Use Terraform outputs to display the ALB DNS name.
