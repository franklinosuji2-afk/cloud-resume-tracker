<<<<<<< HEAD
# cloud-resume-tracker
=======
# Cloud Resume Tracker 🚀

A portfolio project demonstrating **Cloud + DevOps skills**:

- AWS S3 + CloudFront → host static resume website
- AWS Lambda + API Gateway + DynamoDB → visitor counter
- Terraform → Infrastructure as Code
- GitHub Actions → CI/CD pipeline

## 🏗️ Architecture
1. User visits resume → CloudFront → S3
2. Frontend JS calls API Gateway
3. API Gateway → Lambda → DynamoDB updates visitor count
4. GitHub Actions auto-deploys infra + frontend

## 🚀 How to Deploy
1. Clone repo & `cd terraform`
2. Run `terraform init && terraform apply`
3. Upload `frontend/` to S3
4. Open the CloudFront URL 🎉

## 📦 Tech Stack
- AWS (S3, CloudFront, Lambda, DynamoDB, API Gateway)
- Terraform
- GitHub Actions
# Cloud Resume Tracker

This is my cloud project. 6142b44 (Initial commit: Cloud Resume Tracker project)
This is my personal resume project hosted on GitHub.

