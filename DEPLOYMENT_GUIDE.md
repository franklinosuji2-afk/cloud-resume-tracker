cd /home/user/cloud-resume-tracker && cat DEPLOYMENT_GUIDE.md
session: default
# 🚀 Deployment Guide

## Quick Start

### Option 1: Automated Deployment (Recommended)

**For Windows (PowerShell):**
```powershell
.\deploy.ps1
```

**For Linux/Mac (Bash):**
```bash
chmod +x deploy.sh
./deploy.sh
```

The script will:
1. ✅ Verify AWS credentials and tools
2. 📦 Deploy all infrastructure with Terraform
3. 📝 Update frontend with API URL
4. 📤 Upload frontend to S3
5. 🔢 Initialize visitor counter
6. 🌐 Display your website URL

---

## Option 2: Manual Deployment

### Step 1: Configure AWS

```bash
aws configure
```

Enter:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., us-east-1)
- Output format (json)

### Step 2: Update Bucket Name

Edit `terraform/variables.tf`:
```hcl
variable "bucket_name" {
  default = "your-unique-bucket-name-12345"  # Change this!
}
```

### Step 3: Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Save the outputs:
- `api_gateway_url`
- `cloudfront_url`
- `s3_bucket_name`

### Step 4: Update Frontend

Edit `frontend/script.js` and replace:
```javascript
const API_URL = "YOUR_API_GATEWAY_URL_HERE";
```

With your actual API Gateway URL from terraform outputs.

### Step 5: Upload Frontend

```bash
cd ..
aws s3 sync frontend/ s3://YOUR_BUCKET_NAME/ --delete
```

### Step 6: Initialize Counter

```bash
aws dynamodb put-item \
  --table-name Visitors \
  --item '{"id": {"S": "counter"}, "visits": {"N": "0"}}'
```

### Step 7: Test

Visit your CloudFront URL and verify the visitor counter works!

---

## GitHub Actions Setup (Optional)

Enable automated deployments on every push:

1. Go to GitHub repository → Settings → Secrets and variables → Actions
2. Add these secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION`

Now every push to `main` will auto-deploy!

---

## Troubleshooting

### "Bucket name already exists"
S3 bucket names must be globally unique. Change `bucket_name` in `terraform/variables.tf`.

### "Access Denied" errors
Ensure your AWS user has these permissions:
- S3 (Full Access)
- Lambda (Full Access)
- API Gateway (Full Access)
- DynamoDB (Full Access)
- CloudFront (Full Access)
- IAM (Create Roles and Policies)

### Visitor count not updating
1. Check browser console for errors
2. Verify API URL is correct in `script.js`
3. Check Lambda CloudWatch logs:
   ```bash
   aws logs tail /aws/lambda/cloud-resume-visitor-counter --follow
   ```

### CloudFront not serving updated content
CloudFront caches content. Create an invalidation:
```bash
DISTRIBUTION_ID=$(aws cloudfront list-distributions --query "DistributionList.Items[0].Id" --output text)
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*"
```

---

## Cleanup

To remove all resources and avoid charges:

```bash
# Empty S3 bucket first
aws s3 rm s3://YOUR_BUCKET_NAME --recursive

# Destroy infrastructure
cd terraform
terraform destroy
```

---

## Cost Estimate

With AWS Free Tier:
- **S3**: 5GB storage, 20,000 GET requests (FREE)
- **CloudFront**: 1TB transfer, 10M requests (FREE for 12 months)
- **Lambda**: 1M requests, 400,000 GB-seconds (FREE)
- **DynamoDB**: 25GB storage, 25 WCU, 25 RCU (FREE)
- **API Gateway**: 1M API calls (FREE for 12 months)

**Estimated monthly cost**: $0.00 (within free tier)

After free tier: ~$1-3/month for low traffic