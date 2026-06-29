# ☁️ Cloud Resume Tracker

> **A fully serverless cloud-native resume platform built on AWS with Infrastructure as Code and automated CI/CD.**

Cloud Resume Tracker is my implementation of the **Cloud Resume Challenge**, built to demonstrate practical skills in **Cloud Engineering**, **DevOps**, **serverless architecture**, and **automation**.

The project hosts a static resume website on AWS and integrates a serverless backend that tracks visitor count in real time using event-driven cloud services.

Built with:

* Amazon Web Services S3
* Amazon Web Services CloudFront
* Amazon Web Services Lambda
* Amazon Web Services API Gateway
* Amazon Web Services DynamoDB
* Terraform
* [GitHub Actions](https://github.com/features/actions?utm_source=chatgpt.com)

---

# 🚀 Project Overview

Modern cloud-native applications should be:

* scalable
* highly available
* automated
* cost-efficient
* infrastructure-driven

Cloud Resume Tracker demonstrates all five.

Instead of traditional web hosting, this project uses a **serverless AWS architecture** where infrastructure automatically scales with demand while maintaining minimal operational overhead.

The visitor counter adds a dynamic backend component, transforming a static resume into a production-style cloud application.

---

# 🎯 What This Project Demonstrates

This project showcases practical experience in:

✅ Serverless architecture design
✅ AWS service integration
✅ Infrastructure as Code (IaC)
✅ CI/CD automation
✅ Static website hosting
✅ Event-driven backend design
✅ Cloud security and access control
✅ Production deployment workflows

---

# 🏗 Architecture Overview

```text id="2aj1k0"
User Browser
    │
    ▼
CloudFront CDN
    │
    ▼
Amazon S3 (Static Resume Website)
    │
    ▼
Frontend JavaScript
    │
    ▼
API Gateway
    │
    ▼
AWS Lambda (Python)
    │
    ▼
Amazon DynamoDB
```

---

# 🔄 Request Flow

1. User visits resume website via CloudFront
2. Static frontend loads from S3
3. JavaScript calls API Gateway endpoint
4. API Gateway invokes Lambda function
5. Lambda updates visitor count in DynamoDB
6. Updated count is returned to frontend

The entire backend is fully event-driven.

No servers are provisioned or managed manually.

---

# ⚙️ Technology Stack

| Layer    | Technology                                                                   |
| -------- | ---------------------------------------------------------------------------- |
| Frontend | HTML, CSS, JavaScript                                                        |
| Backend  | Amazon Web Services Lambda (Python 3.12)                                     |
| Database | Amazon Web Services DynamoDB                                                 |
| Hosting  | Amazon Web Services S3 + CloudFront                                          |
| API      | Amazon Web Services API Gateway                                              |
| IaC      | Terraform                                                                    |
| CI/CD    | [GitHub Actions](https://github.com/features/actions?utm_source=chatgpt.com) |

---

# ✨ Features

---

## Serverless Hosting

Static frontend served globally via CloudFront.

Benefits:

* low latency
* high availability
* CDN caching
* HTTPS by default

---

## Real-Time Visitor Counter

Dynamic visitor count powered by:

* API Gateway
* Lambda
* DynamoDB

Every page visit triggers a backend API call.

---

## Infrastructure as Code

All AWS infrastructure is provisioned using Terraform.

Benefits:

* version control
* reproducibility
* automation
* easy rollback

---

## CI/CD Automation

Deployment pipeline automates infrastructure and frontend delivery.

---

# 📁 Project Structure

```bash id="i9x32s"
cloud-resume-tracker/
│
├── frontend/
│   ├── index.html
│   ├── script.js
│   └── styles.css
│
├── backend/
│   ├── lambda_function.py
│   └── requirements.txt
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── .github/workflows/
│   └── deploy.yml
│
├── deploy.sh
├── deploy.ps1
└── README.md
```

---

# 🚀 Deployment

---

## Prerequisites

Install and configure:

* AWS Account
* [AWS CLI](https://aws.amazon.com/cli/?utm_source=chatgpt.com)
* Terraform
* Git

---

## Clone Repository

```bash id="wh19zz"
git clone https://github.com/franklinosuji2-afk/cloud-resume-tracker.git
cd cloud-resume-tracker
```

---

## Configure Terraform Variables

Update bucket name in:

```text id="u0k5ef"
terraform/variables.tf
```

Example:

```hcl id="9m3l7g"
variable "bucket_name" {
  default = "your-unique-bucket-name"
}
```

Bucket names must be globally unique.

---

## Deploy Infrastructure

```bash id="wn3bm1"
cd terraform
terraform init
terraform plan
terraform apply
```

Terraform outputs:

* API Gateway URL
* CloudFront URL
* S3 bucket name

---

## Upload Frontend Assets

```bash id="gz3j3h"
aws s3 sync ../frontend/ s3://YOUR_BUCKET_NAME
```

---

## Access Website

Open the CloudFront URL provided by Terraform.

---

# 🔄 CI/CD Pipeline

The repository includes automated deployment via GitHub Actions.

Pipeline tasks:

* validate infrastructure
* deploy Terraform resources
* upload frontend assets
* publish changes

Workflow file:

```text id="nn0gmd"
.github/workflows/deploy.yml
```

---

## Required GitHub Secrets

Configure:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_REGION`

---

# 🧪 Testing

Test API directly:

```bash id="f2tsm7"
curl https://YOUR_API_GATEWAY_URL
```

Expected response:

```json id="g06ezl"
{
  "visits": 1
}
```

---

# 🔐 Security Considerations

Best practices implemented:

### Least Privilege Access

IAM permissions restricted to required services.

### HTTPS Everywhere

CloudFront ensures encrypted traffic.

### CORS Configuration

API access restricted to allowed origins.

### No Hardcoded Secrets

Secrets stored outside source code.

---

# 💰 Cost

Designed to remain within AWS Free Tier for portfolio usage.

| Service     | Cost Profile         |
| ----------- | -------------------- |
| Lambda      | Free for low traffic |
| API Gateway | Minimal usage cost   |
| DynamoDB    | Free tier eligible   |
| S3          | Extremely low        |
| CloudFront  | Low traffic friendly |

Expected cost under portfolio traffic:

# **Near $0/month**

---

# 📚 What I Learned

This project strengthened practical knowledge in:

* serverless application design
* AWS infrastructure provisioning
* Terraform workflows
* CI/CD automation
* API integration
* DynamoDB data modeling
* cloud deployment operations

---

# 🔧 Troubleshooting

---

## Bucket Already Exists

S3 bucket names are globally unique.

Update:

```text id="7snlzj"
terraform/variables.tf
```

---

## CORS Errors

Verify frontend uses correct API Gateway URL.

---

## Visitor Counter Not Updating

Check:

* Lambda logs
* API Gateway configuration
* DynamoDB permissions

Logs available in CloudWatch.

---

## Terraform Failure

Verify:

* AWS credentials
* IAM permissions
* selected region

---

# 🧹 Cleanup

Destroy infrastructure to avoid charges.

```bash id="s9cly4"
cd terraform
terraform destroy
```

Delete S3 objects:

```bash id="7u83dk"
aws s3 rm s3://YOUR_BUCKET_NAME --recursive
```

---

# 🔮 Future Improvements

Planned enhancements:

* Custom domain with SSL
* Resume CMS
* Authentication
* Analytics dashboard
* Visitor geolocation insights
* Blue/green deployments
* Multi-environment support

---

# 💡 Why This Project Matters

Many portfolio websites are static.

Few demonstrate **real cloud engineering**.

Cloud Resume Tracker transforms a personal resume into a production-grade cloud application showcasing:

* cloud architecture
* automation
* serverless engineering
* DevOps best practices

This reflects the mindset expected from modern **Cloud Engineers**, **DevOps Engineers**, and **Platform Engineers**.

---

# 👨‍💻 Author

## Franklin Osuji

Cloud & DevOps Engineer

AWS | Terraform | Serverless | CI/CD | Platform Engineering

* [GitHub Profile](https://github.com/franklinosuji2-afk?utm_source=chatgpt.com)
* [LinkedIn Profile](https://www.linkedin.com/in/franklin-osuji-a96003321/?utm_source=chatgpt.com)

> Building scalable, automated cloud systems with infrastructure as code.

---

# 📄 License

Licensed under the **MIT License**.

---

# 🙏 Acknowledgments

Inspired by the **Cloud Resume Challenge** created by .
