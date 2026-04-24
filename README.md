# Terraform AWS Infrastructure

- Reusable and modular Terraform configurations for provisioning AWS infrastructure.
- This repository provides a collection of production-ready modules.
- Working examples to help you quickly deploy and understand real-world setups.

## Repository structure
<pre>
terraform-aws-infrastructure/
├── modules/    # Reusable Terraform modules
├── examples/   # Complete working infrastructure examples
└── README.md
</pre>

## Modules

- The **modules/** directory holds reusable Terraform building blocks.

- Each module is designed to be:
  - Independent and focused on a single AWS service
  - Easily configurable using input variables
  - Reusable across multiple projects

## Available modules

- **ec2** – Launches EC2 instances with configurable settings
- **vpc** – Creates VPC, subnets, and networking components

## Examples
- The **examples/** directory demonstrates how to combine modules into real infrastructure setups.
- These examples are fully runnable and intended to showcase best practices for module composition.

## Available examples
- **web-app** - Static webpage hosting. Use instance's public ip to access the webpage.

## General usage
1. Clone the repository: `git clone https://github.com/vishal2github/terraform-aws-infrastructure.git`
2. Navigate to an example: `cd terraform-aws-infrastructure/examples/web-app`
3. Initialize Terraform: `terraform init`
4. Preview changes: `terraform plan`
5. Apply configuration: `terraform apply`

## Data flow
<pre>
terraform.tfvars  →  variables.tf (example)
        ↓
  main.tf (example)
        ↓
   module call
        ↓
variables.tf (module)
        ↓
main.tf (module) → creates resources
        ↓
outputs.tf (module)
        ↓
(returned to example)
</pre>

## Prerequisites
- Terraform installed (>= 1.x recommended)
- AWS CLI configured (Command: `aws configure`)
- Ensure your AWS credentials have sufficient permissions to create resources.

## Design principles
- **Modularity** – Each module does one thing well
- **Reusability** – Designed for use across projects
- **Clarity** – Simple and readable configurations
- **Best Practices** – Follows Terraform and AWS guidelines

## Notes
- Avoid hardcoding values. Use variables wherever possible.
- Review Terraform plans before applying changes.
- Clean up resources using terraform destroy to avoid unexpected costs.
