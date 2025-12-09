📝 Cloud Resume Tracker
This project is my implementation of the Cloud Resume Challenge – a serverless, cloud-native resume website built on AWS.
It showcases my skills in DevOps, serverless architecture, and CI/CD automation.

AWS Terraform Python

🏗 Architecture Overview
A portfolio project demonstrating Cloud + DevOps skills:

AWS S3 + CloudFront → Host static resume website
AWS Lambda + API Gateway + DynamoDB → Visitor counter backend
Terraform → Infrastructure as Code (IaC)
GitHub Actions → CI/CD pipeline
How It Works
User visits resume → CloudFront → S3
Frontend JS calls API Gateway
API Gateway triggers Lambda function
Lambda updates visitor count in DynamoDB
GitHub Actions auto-deploys infrastructure + frontend
📦 Tech Stack
Frontend: HTML, CSS, JavaScript
Backend: AWS Lambda (Python 3.12)
Database: Amazon DynamoDB
Hosting: Amazon S3 + CloudFront
CI/CD: GitHub Actions
IaC: Terraform
📂 Project Structure


cloud-resume-tracker/
├── frontend/
│   ├── index.html          # Main resume page
│   ├── styles.css          # Styling
│   └── script.js           # Visitor counter JS
│
├── backend/
│   ├── lambda_function.py  # Lambda function code
│   └── requirements.txt    # Python dependencies
│
├── terraform/
│   ├── main.tf             # Main infrastructure config
│   ├── variables.tf        # Input variables
│   └── outputs.tf          # Output values
│
├── .github/
│   └── workflows/
│       └── deploy.yml      # CI/CD pipeline
│
└── README.md
🚀 Deployment Instructions
Prerequisites
AWS Account with appropriate permissions
AWS CLI configured with credentials
Terraform installed (Download)
Git installed
Step 1: Clone the Repository
bash


git clone https://github.com/franklinosuji2-afk/cloud-resume-tracker.git
cd cloud-resume-tracker
Step 2: Update S3 Bucket Name
Edit terraform/variables.tf and change the bucket name to something unique:

hcl


variable "bucket_name" {
  default = "your-unique-bucket-name-here"
}
Step 3: Deploy Infrastructure with Terraform
bash


cd terraform
terraform init
terraform plan
terraform apply
After deployment completes, note the outputs:

api_gateway_url - Your API endpoint
cloudfront_url - Your website URL
s3_bucket_name - Your S3 bucket name
Step 4: Update Frontend with API URL
Edit frontend/script.js and replace YOUR_API_GATEWAY_URL_HERE with the api_gateway_url from terraform outputs.

Step 5: Upload Frontend to S3
bash


cd ..
aws s3 sync frontend/ s3://YOUR_BUCKET_NAME/ --exclude ".git/*"
Step 6: Visit Your Website
Open the cloudfront_url from terraform outputs in your browser!

🔄 CI/CD with GitHub Actions
The repository includes a GitHub Actions workflow that automatically:

Runs terraform apply on push to main branch
Deploys infrastructure changes
Setup GitHub Secrets
Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION (e.g., us-east-1)
🧪 Testing
Test the API endpoint directly:

bash


curl https://YOUR_API_GATEWAY_URL
Expected response:

json


{"visits": 1}
🛠️ How to Customize
Update Resume Content: Edit frontend/index.html
Change Styling: Modify frontend/styles.css
Add Features: Extend backend/lambda_function.py
Configure AWS Region: Update terraform/variables.tf
💡 Features
✅ Serverless architecture (no servers to manage)
✅ Auto-scaling and highly available
✅ Free Tier compatible (minimal costs)
✅ Infrastructure as Code with Terraform
✅ Automated deployments with GitHub Actions
✅ Real-time visitor counter
✅ HTTPS enabled via CloudFront
✅ CORS configured for API access

📚 What I Learned
Setting up serverless applications on AWS
Writing Infrastructure as Code with Terraform
Configuring CI/CD pipelines with GitHub Actions
Integrating frontend with backend APIs
Managing AWS services (S3, CloudFront, Lambda, API Gateway, DynamoDB)
Implementing visitor tracking with DynamoDB
🔧 Troubleshooting
Issue: S3 bucket name already exists
Solution: Change bucket_name in terraform/variables.tf to a globally unique name

Issue: API Gateway returns CORS errors
Solution: CORS is configured in terraform. Ensure you're using the correct API URL

Issue: Visitor count not updating
Solution: Check CloudWatch logs for Lambda function errors

Issue: Terraform apply fails
Solution: Ensure AWS credentials are configured correctly with aws configure

🧹 Cleanup
To avoid AWS charges, destroy all resources when done:

bash


cd terraform
terraform destroy
Then manually delete the S3 bucket contents:

bash


aws s3 rm s3://YOUR_BUCKET_NAME --recursive
📖 Resources
AWS Cloud Resume Challenge
Terraform AWS Provider Docs
AWS Lambda Documentation
AWS API Gateway Documentation
GitHub Actions Documentation
📝 Author
Franklin Osuji – DevOps & Cloud Enthusiast

🔗 LinkedIn: Franklin Osuji
💻 GitHub: @franklinosuji2-afk
📧 Email: franklin.osuji2@gmail.com
📜 License
This project is licensed under the MIT License - see the LICENSE [blocked] file for details.

🌟 Acknowledgments
Inspired by the Cloud Resume Challenge by Forrest Br