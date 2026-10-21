resource "aws_launch_template" "blue" {
  name          = local.blue_template_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true

    security_groups = [
      data.aws_security_group.ssh.id,
      data.aws_security_group.http.id
    ]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    echo '<h1>Blue Environment</h1>' > /var/www/html/index.html
    systemctl enable httpd
    systemctl start httpd
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.project_id}-blue-instance"
      Project     = var.project_id
      Environment = "Blue"
      Terraform   = "true"
    }
  }

  tags = {
    Name        = local.blue_template_name
    Project     = var.project_id
    Environment = "Blue"
    Terraform   = "true"
  }
}

resource "aws_launch_template" "green" {
  name          = local.green_template_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true

    security_groups = [
      data.aws_security_group.ssh.id,
      data.aws_security_group.http.id
    ]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    echo '<h1>Green Environment</h1>' > /var/www/html/index.html
    systemctl enable httpd
    systemctl start httpd
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.project_id}-green-instance"
      Project     = var.project_id
      Environment = "Green"
      Terraform   = "true"
    }
  }

  tags = {
    Name        = local.green_template_name
    Project     = var.project_id
    Environment = "Green"
    Terraform   = "true"
  }
}

resource "aws_autoscaling_group" "blue" {
  name = local.blue_asg_name

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  vpc_zone_identifier = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  target_group_arns = [
    aws_lb_target_group.blue.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 180

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = local.blue_asg_name
    propagate_at_launch = false
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "Blue"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green" {
  name = local.green_asg_name

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  vpc_zone_identifier = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  target_group_arns = [
    aws_lb_target_group.green.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 180

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = local.green_asg_name
    propagate_at_launch = false
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "Green"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
}
