output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.project_lb.dns_name
}

# To retrieve instance details, use a different method such as querying EC2 instances by tags.

# Create a data source to fetch instances by tags
data "aws_instances" "project_instances" {
  filter {
    name   = "tag:Name"
    values = ["project-instance"]
  }
}

output "instance_ips" {
  description = "IP addresses of instances in the Auto Scaling Group"
  value       = data.aws_instances.project_instances.private_ips
}

