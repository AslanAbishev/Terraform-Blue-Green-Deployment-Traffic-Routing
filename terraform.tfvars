aws_region = "eu-west-1"
project_id = "cmtr-7fdui0mc"

vpc_name            = "cmtr-7fdui0mc-vpc"
public_subnet1_name = "cmtr-7fdui0mc-public-subnet1"
public_subnet2_name = "cmtr-7fdui0mc-public-subnet2"

ssh_security_group_name  = "cmtr-7fdui0mc-sg-ssh"
http_security_group_name = "cmtr-7fdui0mc-sg-http"
lb_security_group_name   = "cmtr-7fdui0mc-sg-lb"

instance_type = "t3.micro"

ami_name_regex = "^al2023-ami-2023.*-x86_64$"
ami_owners     = ["amazon"]

blue_weight  = 100
green_weight = 0

asg_min_size         = 1
asg_max_size         = 1
asg_desired_capacity = 1
