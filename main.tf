provider "aws" {
  region = var.aws_region
}

locals {
  lb_name             = "${var.project_id}-lb"
  blue_tg_name        = "${var.project_id}-blue-tg"
  green_tg_name       = "${var.project_id}-green-tg"
  blue_template_name  = "${var.project_id}-blue-template"
  green_template_name = "${var.project_id}-green-template"
  blue_asg_name       = "${var.project_id}-blue-asg"
  green_asg_name      = "${var.project_id}-green-asg"
}
