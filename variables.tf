variable "aws_region" {
  description = "AWS region where the resources are deployed."
  type        = string
}

variable "project_id" {
  description = "Project identifier used to construct resource names and tags."
  type        = string
}

variable "vpc_name" {
  description = "Name of the existing VPC."
  type        = string
}

variable "public_subnet1_name" {
  description = "Name of the first existing public subnet."
  type        = string
}

variable "public_subnet2_name" {
  description = "Name of the second existing public subnet."
  type        = string
}

variable "ssh_security_group_name" {
  description = "Name of the existing security group used for SSH access."
  type        = string
}

variable "http_security_group_name" {
  description = "Name of the existing security group used for HTTP access to EC2 instances."
  type        = string
}

variable "lb_security_group_name" {
  description = "Name of the existing security group used by the Application Load Balancer."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used by Blue and Green environments."
  type        = string
}

variable "ami_name_regex" {
  description = "Regular expression used to locate the Amazon Linux 2023 AMI."
  type        = string
}

variable "ami_owners" {
  description = "List of trusted owners for the selected AMI."
  type        = list(string)
}

variable "blue_weight" {
  description = "Traffic weight assigned to the Blue target group."
  type        = number
}

variable "green_weight" {
  description = "Traffic weight assigned to the Green target group."
  type        = number
}

variable "asg_min_size" {
  description = "Minimum number of instances in each Auto Scaling group."
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of instances in each Auto Scaling group."
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in each Auto Scaling group."
  type        = number
}
