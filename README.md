# AWS Infrastructure Setup for React + Express App with Terraform

#### This project provisions an infrastructure on AWS using Terraform to host a React frontend and an Express.js backend. The frontend is served through CloudFront and stored in S3, while the backend is hosted on an EC2 instance behind an Application Load Balancer (ALB).

### Prerequisites:

- Terraform installed
- AWS CLI installed and configured with appropriate credentials.
- An SSH key to access the EC2 instance (by default it looks for ~/.ssh/id_rsa_new.pub).

#

### Infrastructure Components:

### VPC

1. Creates a VPC with a CIDR block of 10.0.0.0/16.
2. Two public subnets are provisioned in different availability zones for high availability.
3. An Internet Gateway is created to allow outbound traffic.
4. A Route Table and Route Table Associations are created to route internet traffic to the subnets.

### S3 Bucket for Frontend

1. Creates an S3 bucket to store the React frontend.
2. Versioning is enabled for better control over changes.
3. Website configuration is applied for the S3 bucket to host the static React files (index.html).
4. A CloudFront Origin Access Identity (OAI) is used to securely access the S3 bucket from CloudFront.
5. The bucket's public access is blocked, and a Bucket Policy allows access only from CloudFront.

### CloudFront Distribution

1. A CloudFront distribution is created to serve the React app with global low-latency access.
2. The default cache behavior is configured with a viewer protocol policy of "redirect-to-https".
3. Allowed methods include HTTP methods like GET, POST, and DELETE, while cached methods are limited to GET and HEAD.
4. Cache settings forward query strings, cookies, and headers like Origin and Authorization to the origin.
5. The distribution is configured with a default certificate for SSL support (using CloudFront's default certificate).

### EC2 for Backend

1. An EC2 instance is created to run the Express backend.
2. The instance is provisioned with Node.js, npm, and pm2 using user data.
3. A Key Pair is used for SSH access to the instance.
4. The instance is associated with a Security Group that allows:
   - HTTP traffic on port 80.
   - SSH traffic on port 22.
   - Traffic on port 3000 for the Express app.
   - Specific access from CloudFront via managed prefix lists.

### Application Load Balancer (ALB)

1. An Application Load Balancer (ALB) distributes traffic across the backend EC2 instance.
2. The ALB listens on port 80 and forwards traffic to a Target Group associated with the backend instance.
3. A health check is configured to monitor the status of the backend.

### Variables

#### The project uses several variables defined in variables.tf:

1. region: AWS region where resources will be created (default: eu-central-1).
2. instance_type: EC2 instance type for the backend (default: t2.micro).
3. ami: AMI ID for the EC2 instance (default: ami-0de02246788e4a354).
4. cloudfront_prefix_id: Managed CloudFront prefix list ID for secure access to the backend.
5. environment: The environment name (default: dev).

### Outputs

1. Public IP address of the EC2 instance.
2. The VPC ID and subnet IDs.
3. The DNS name of the ALB.
4. The website endpoint for the S3 bucket.
5. The CloudFront distribution URL.

#

### Usage

- #### Initialize Terraform: `terraform init`
- #### Plan the Infrastructure: `terraform plan`
- #### Apply the Configuration: `terraform apply`
- #### Access Resources: `ssh -i ~/.ssh/id_rsa_new ec2-user@<instance_public_ip>`
- #### Cleanup: `terraform destroy`
