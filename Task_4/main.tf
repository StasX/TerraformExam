module "vpc_n_ec2" {
  source           = "./modules/vpc_n_ec2"
  vpc_cidr         = "10.0.0.0/16"
  subnet_count     = 4
  instance_type    = var.instance_type
  assign_public_ip = true
  ami_type         = var.ami_type
  az               = var.az
  region_type      = var.region
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
  count            = length(module.vpc_n_ec2.instances_ids)
  target_group_arn = aws_lb_target_group.exam_tg.arn
  target_id        = module.vpc_n_ec2.instances_ids[count.index]
  port             = 80
}

resource "aws_launch_template" "exam_template" {
  name_prefix   = "exam-"
  image_id      = var.ami_type
  instance_type = var.instance_type
  key_name      = module.vpc_n_ec2.key_name
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [module.vpc_n_ec2.exam_sg]
  }
}
resource "aws_autoscaling_group" "exam_asg" {
  name                = "exam-autoscaling-group"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3
  vpc_zone_identifier = module.vpc_n_ec2.subnets

  launch_template {
    id      = aws_launch_template.exam_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Auto Scaling Group Instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_scaling" {
  name                   = "cpu-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.exam_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0
  }
}
