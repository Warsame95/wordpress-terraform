# WordPress Deployment on AWS via Terraform

This repository contains Terraform configuration to deploy a WordPress site on AWS. It provisions the necessary AWS resources, sets up the environment, and configures WordPress using a user-data script.

---

## Features

- Deploys a VPC, subnets, security groups, and other networking essentials.  
- Launches EC2 instance with WordPress installed automatically via a `user_data` script.  
- Makes use of Terraform to manage infrastructure as code.  

---

## Prerequisites

Before getting started, ensure you have:

- An AWS account with permissions to create VPCs, subnets, EC2, IAM, Security Groups, etc.  
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed (check `provider.tf` for recommended version).  
- AWS CLI configured with your credentials, or environment variables set up for Terraform.  

---

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/Warsame95/wordpress-terraform.git
cd wordpress-terraform
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review & Apply Infrastructure
```bash
terraform plan
terraform apply
```

---

## Future Enhancements

- Break into reusable Terraform modules (network, compute, etc.).
- Use RDS for database instead of local MySQL.
- Add HTTPS with ALB + ACM certificate.
- Implement auto-scaling for high availability.
- Manage secrets securely with AWS Secrets Manager.

