
# AWS Infrastructure Deployment using Terraform

This project sets up a basic AWS infrastructure using Terraform. It includes an EC2 Auto Scaling Group, Application Load Balancer (ALB), Security Groups, and a Launch Template.

## Prerequisites

1. **AWS Account**: Ensure you have an AWS account and the necessary credentials to deploy resources.
2. **Terraform**: Install Terraform by following the instructions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).
3. **AWS CLI**: Install and configure the AWS CLI to manage AWS resources.

## Setup and Usage

1. **Clone this repository**:
   ```bash
   git clone aryamanmaurya/scalable-web-architructure
   cd scalable-web-architructure
   ```

2. **Initialize Terraform**:
   Run the following command to initialize the working directory with the required providers and modules.
   ```bash
   terraform init
   ```

3. **Configure Variables**:
   You can update the default values for the variables in the `variables.tf` file or pass them during deployment.

4. **Deploy the Infrastructure**:
   To create the infrastructure, run the following command:
   ```bash
   terraform apply
   ```
   Review the plan and type `yes` to proceed.

5. **Destroy the Infrastructure**:
   If you want to delete the infrastructure, run:
   ```bash
   terraform destroy
   ```

## Configuration Details

### Resources Created:
- **EC2 Auto Scaling Group**: A scalable group of EC2 instances.
- **Application Load Balancer**: Distributes traffic across EC2 instances.
- **Launch Template**: Template for launching EC2 instances with predefined settings.
- **Security Groups**: Controls access to EC2 instances and the Load Balancer.
- **Target Group**: For routing traffic to instances managed by the ALB.

### Key Variables (defined in `variables.tf`):
- `region`: AWS region where resources will be deployed (default: `ap-south-1`).
- `vpc_id`: VPC in which the resources will be created.
- `ami_id`: AMI ID for the EC2 instances.
- `instance_type`: EC2 instance type (default: `t2.micro`).
- `key_pair_name`: Key pair name for SSH access.
- `launch_template_name`: Name for the EC2 launch template.
- `lb_name`: Name for the application load balancer.
- `target_group_name`: Name for the ALB target group.
- `subnets`: List of subnets for the Auto Scaling Group and Load Balancer.
- `desired_capacity`: Desired number of instances in the Auto Scaling Group (default: 3).
- `min_size`: Minimum number of instances in the Auto Scaling Group (default: 2).
- `max_size`: Maximum number of instances in the Auto Scaling Group (default: 6).

### Outputs (defined in `outputs.tf`):
- `alb_dns`: The DNS name of the Application Load Balancer.
- `target_group`: The ARN of the target group.
- `instance_ips`: IP addresses of the instances in the Auto Scaling Group.

## Notes
- Ensure that the specified VPC and subnets exist in your AWS account before applying the Terraform plan.
- The security groups allow unrestricted SSH and HTTP access. For production environments, adjust these settings accordingly.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
