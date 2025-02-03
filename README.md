# SimpleTimeService API

## Overview

The **SimpleTimeService** is a simple Go-based microservice that returns the current timestamp and the client's IP address in JSON format. This service is designed to be deployed on Amazon EKS (Elastic Kubernetes Service) using Terraform.

## API Endpoint

- **GET /**: Returns the current timestamp and the client's IP address.

### Response Format

```json
{
  "timestamp": "<current date and time>",
  "ip": "<the IP address of the visitor>"
}
```

# Prerequisites

- Go (version 1.16 or higher)
- Terraform (version 1.0 or higher)
- AWS CLI configured with appropriate permissions
- An AWS account with permissions to create EKS clusters and associated resources

## Step 1: Clone the Repository

```shell
git clone <repository-url>
cd <repository-folder>
```


## Step 2: Configure Terraform
```text
- All the Important configs will be in the file **"terraform.tfvars"**
- Configure them as per your need.
- Optional - Add your own s3 backend (I used local backend with custom path)

Note: Check for EKS module in the folder terraform/modules/eks/main.tf. You may need to change the parameter and provide the user details **"kms_key_administrators"**. (To be changed to temporary permissions later.)

```
## Step 3: Deploy the Infrastructure

```bash
helm repo update
```

```bash
terraform init
terraform plan
terraform apply
```

## Step 4: Access the API


## _Known Issues_ : 
- Helm chart installation for nginx ingress controller is not working as expected due to disabled public EKS access (WIP)
- Test