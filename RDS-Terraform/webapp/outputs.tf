output "load_balancer_dns_name" {
  value = aws_lb.webapp_alb.dns_name
}
output "aws_autoscaling_group" {
  value = aws_autoscaling_group.webapp_asg.name
}   
output "rds_endpoint" {
  value = aws_db_instance.webapp_db.endpoint
}