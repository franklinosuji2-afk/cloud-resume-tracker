cd /home/user/cloud-resume-tracker && cat deploy.sh
session: default
#!/bin/bash

echo "🚀 Cloud Resume Tracker - Deployment Script"
echo "==========================================="

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform is not installed. Please install it first."
    exit 1
fi

# Check AWS credentials
echo "✅ Checking AWS credentials..."
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Run 'aws configure' first."
    exit 1
fi

echo "✅ AWS credentials verified"

# Deploy infrastructure
echo ""
echo "📦 Deploying infrastructure with Terraform..."
cd terraform || exit 1

terraform init
if [ $? -ne 0 ]; then
    echo "❌ Terraform init failed"
    exit 1
fi

terraform plan
if [ $? -ne 0 ]; then
    echo "❌ Terraform plan failed"
    exit 1
fi

terraform apply -auto-approve
if [ $? -ne 0 ]; then
    echo "❌ Terraform apply failed"
    exit 1
fi

echo "✅ Infrastructure deployed successfully"

# Get outputs
echo ""
echo "📊 Getting deployment outputs..."
API_URL=$(terraform output -raw api_gateway_url 2>/dev/null)
CLOUDFRONT_URL=$(terraform output -raw cloudfront_url 2>/dev/null)
BUCKET_NAME=$(terraform output -raw s3_bucket_name 2>/dev/null)

echo "API Gateway URL: $API_URL"
echo "CloudFront URL: $CLOUDFRONT_URL"
echo "S3 Bucket: $BUCKET_NAME"

# Update frontend with API URL
cd ..
echo ""
echo "📝 Updating frontend with API URL..."
sed -i "s|YOUR_API_GATEWAY_URL_HERE|$API_URL|g" frontend/script.js

# Upload frontend to S3
echo ""
echo "📤 Uploading frontend to S3..."
aws s3 sync frontend/ s3://$BUCKET_NAME/ --delete --exclude ".git/*"
if [ $? -ne 0 ]; then
    echo "❌ S3 upload failed"
    exit 1
fi

echo "✅ Frontend uploaded successfully"

# Initialize DynamoDB with counter
echo ""
echo "🔢 Initializing visitor counter in DynamoDB..."
aws dynamodb put-item \
    --table-name Visitors \
    --item '{"id": {"S": "counter"}, "visits": {"N": "0"}}' \
    --return-consumed-capacity TOTAL 2>/dev/null

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🌐 Your website is now live at:"
echo "   $CLOUDFRONT_URL"
echo ""
echo "🔗 API Endpoint:"
echo "   $API_URL"
echo ""
echo "⏳ Note: CloudFront distribution may take 10-15 minutes to fully propagate."