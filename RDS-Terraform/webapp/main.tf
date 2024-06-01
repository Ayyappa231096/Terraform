#Define the AWS provider
provider "aws" {
    region = var.region
  
}
#Create a security group for the Application Load Balancer
resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    description = "Security group for Application Load Balancer"
    vpc_id = var.vpc_id

    #Define ingress rules for the ALB

    ingress = {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_block=["0.0.0.0/0"]
    }

    #Allow traffic from ALB to instances
    egress = {
        from_port = 0
        to_port = 0
        protocol ="-1"
        cidr_block=["0.0.0.0/0"]
    }
}

#Create an Application Load Balancer

resource "aws_lb" "webapp_alb" {
    name = "webapp-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb_sg ]
    subnets = var.subnet_ids
}
    # Define listener for HTTP traffic
    resource"aws_lb_listener""webapp_listener"{
       load_balancer_arn = aws_lb.webapp_alb.arn
       port = 80
       protocol = "HTTP"

       default_action {
         type = "fixed-response"
         fixed_response {
           content_type = "text/plain"
           message_body = "OK"
           status_code = "200"
         }
       }
}
# Create an Auto Scaling Group
resource "aws_autoscaling_group" "webapp_asg" {
    name = "webapp-asg"
    max_size = var.max_size
    min_size = var.min_size
    desired_capacity = var.desired_capacity
    vpc_zone_identifier = var.subnet_ids
    launch_configuration = aws_launch_configuration.webapp_lc.name

    # Configure health checks for instances
    health_check_type = "ELB"
    health_check_grace_period = 300
  
}
# Create a lauch Configuration
resource "aws_launch_configuration" "webapp_lc" {
    name_prefix = "webapp-lc"
    image_id = var.ami_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.alb_sg.id]
    user_data = var.user_data
    lifecycle {
      create_before_destroy = true
    }
}
#Create an RDS instance for database
resource "aws_db_instance" "webapp_db" {
    identifier = "webapp-db"
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    allocated_storage = var.db_allocated_storage
    db_subnet_group_name = var.db_subnet_group_name
    vpc_security_group_ids = [aws_security_group.alb_sg.id]
    username = var.db_username 
    password = var.db_password
    publicly_accessible = false
}

