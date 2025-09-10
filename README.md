Cloud Resume Tracker 🚀

This project is my implementation of the **Cloud Resume Challenge** a serverless, cloud-native resume website built on **AWS**.  
It showcases my skills in DevOps, serverless architecture, and CI/CD automation.

A portfolio project demonstrating *Cloud + DevOps skills*

- AWS S3 + CloudFront → host static resume website
- AWS Lambda + API Gateway + DynamoDB → visitor counter
- Terraform → Infrastructure as Code
- GitHub Actions → CI/CD pipeline

## 🏗 Architecture
1. User visits resume → CloudFront → S3
2. Frontend JS calls API Gateway
3. API Gateway → Lambda → DynamoDB updates visitor count
4. GitHub Actions auto-deploys infra + frontend

##  How to Deploy
1. Clone repo & `cd terraform`
2. Run `terraform init && terraform apply´
3. Upload `frontend/` to S3
4. Open the CloudFront URL 

## 📦 Tech Stack
- AWS (S3, CloudFront, Lambda, DynamoDB, API Gateway)
- Terraform
- GitHub Actions

# 🚀 Project Overview
The Cloud Resume Tracker is designed to:
- Host a static resume website (HTML, CSS, JS) on **Amazon S3 + CloudFront**
- Use **API Gateway** + **AWS Lambda (Python)** to process visitor requests
- Store visitor count data in **DynamoDB**
- Automate deployments with **GitHub Actions**
- Manage infrastructure using **Terraform**

# 🛠️ Tech Stack
- **Frontend:** HTML, CSS, JavaScript
- **Backend:** AWS Lambda (Python)
- **Database:** DynamoDB
- **Hosting:** S3 + CloudFront
- **CI/CD:** GitHub Actions
- **IaC:** Terraform

# 📂 Project Structure
cloud-resume-tracker/
│── frontend/
│ ├── index.html
│ ├── styles.css
│ ├── script.js
│
│── backend/
│ └── lambda_function.py
│
│── terraform/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
│
│── .github/
│ └── workflows/
│ └── deploy.yml
│
└── README.md


# ⚙️ How It Works
1. A user visits the **resume site** hosted on **S3 + CloudFront**.
2. The frontend calls an **API Gateway endpoint**.
3. The request triggers a **Lambda function** that:
   - Reads/Writes visitor count from **DynamoDB**.
   - Returns the updated count to the frontend.
4. The frontend updates the **visitor count on the resume**.
5. **GitHub Actions** handles CI/CD automatically deploying updates.
6. **Terraform** defines and manages all infrastructure resources.


📜 List of Commands Used in VS Code for Cloud Resume Tracker
1. Create project folder & initialize Git
# Navigate to your project directory
cd C:\Users\DCI-Student\Desktop\DevOps-python

# Create project folder
mkdir cloud-resume-tracker
cd cloud-resume-tracker

# Initialize Git
git init

2. Setup Python virtual environment
# Create a Python virtual environment
python -m venv venv

# Activate the virtual environment
venv\Scripts\activate

3. Configure GitHub identity
git config --global user.name "Github Username"
git config --global user.email "your-email-linked-to-github"

4. Setup GitHub authentication (SSH method)
# Generate SSH key
ssh-keygen -t ed25519 -C "your-email-linked-to-github"

# Start SSH agent
eval $(ssh-agent -s)

# Add key to agent
ssh-add ~/.ssh/id_ed25519

# Test SSH connection
ssh -T git@github.com

5. Connect local repo to GitHub
# Link to GitHub repository (SSH URL)
git remote add origin git@github.com:repolink

# Verify remote URL
git remote -v

6. Add files and commit
# Stage all files
git add .

# Commit changes
git commit -m "Initial commit: Cloud Resume Tracker project"

7. Fix GitHub push permission issue
# Try to push
git push -u origin main

# (Error: remote had README, so we rebased)

# Pull with rebase to avoid conflicts
git pull origin main --rebase

# If conflict in README.md → open file in VS Code, fix manually, then:
git add README.md
git rebase --continue

8. Push project successfully
git push -u origin main


📝 Author

Franklin Osuji  
- LinkedIn: [Franklin Osuji](https://www.linkedin.com/in/franklin-osuji-a96003321/)  
- GitHub: [franklinosuji2-afk]
- Email: franklin.osuji2@gmail.com

- 📜 License
  This project is licensed under the MIT License see the [LICENSE](LICENSE) file for details.










