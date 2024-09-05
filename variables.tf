variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-06bcee513dcc419f7"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-02b49a24cfb95941c"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Key pair name"
  type        = string
  default     = "aa"
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
  default     = "project-security-group"
}

variable "launch_template_name" {
  description = "Name for the EC2 launch template"
  type        = string
  default     = "project-template"
}

variable "lb_name" {
  description = "Name for the application load balancer"
  type        = string
  default     = "project-load-balancer"
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
  default     = "project-target-group"
}

variable "subnets" {
  description = "List of subnets for the Auto Scaling Group and Load Balancer"
  type        = list(string)
  default     = ["subnet-06a0bd84fdb09f5e8", "subnet-0b866df55f66458db"]
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 6
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

