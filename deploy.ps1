cd /home/user/cloud-resume-tracker && cat deploy.ps1
session: default
# Cloud Resume Tracker - PowerShell Deployment Script

Write-Host "🚀 Cloud Resume Tracker - Deployment Script" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan

# Check if AWS CLI is installed
if (-not (Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Host "❌ AWS CLI is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

# Check if Terraform is installed
if (-not (Get-Command terraform -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Terraform is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

# Check AWS credentials
Write-Host "✅ Checking AWS credentials..." -ForegroundColor Green
try {
    aws sts get-caller-identity | Out-Null
    if ($LASTEXITCODE -ne 0) { throw }
    Write-Host "✅ AWS credentials verified" -ForegroundColor Green
}
catch {
    Write-Host "❌ AWS credentials not configured. Run 'aws configure' first." -ForegroundColor Red
    exit 1
}

# Deploy infrastructure
Write-Host ""
Write-Host "📦 Deploying infrastructure with Terraform..." -ForegroundColor Yellow
Set-Location terraform

terraform init
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Terraform init failed" -ForegroundColor Red
    exit 1
}

terraform plan
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Terraform plan failed" -ForegroundColor Red
    exit 1
}

terraform apply -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Terraform apply failed" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Infrastructure deployed successfully" -ForegroundColor Green

# Get outputs
Write-Host ""
Write-Host "📊 Getting deployment outputs..." -ForegroundColor Yellow
$API_URL = terraform output -raw api_gateway_url
$CLOUDFRONT_URL = terraform output -raw cloudfront_url
$BUCKET_NAME = terraform output -raw s3_bucket_name

Write-Host "API Gateway URL: $API_URL" -ForegroundColor Cyan
Write-Host "CloudFront URL: $CLOUDFRONT_URL" -ForegroundColor Cyan
Write-Host "S3 Bucket: $BUCKET_NAME" -ForegroundColor Cyan

# Update frontend with API URL
Set-Location ..
Write-Host ""
Write-Host "📝 Updating frontend with API URL..." -ForegroundColor Yellow
$scriptContent = Get-Content frontend/script.js -Raw
$scriptContent = $scriptContent -replace "YOUR_API_GATEWAY_URL_HERE", $API_URL
Set-Content -Path frontend/script.js -Value $scriptContent

# Upload frontend to S3
Write-Host ""
Write-Host "📤 Uploading frontend to S3..." -ForegroundColor Yellow
aws s3 sync frontend/ s3://$BUCKET_NAME/ --delete --exclude ".git/*"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ S3 upload failed" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Frontend uploaded successfully" -ForegroundColor Green

# Initialize DynamoDB with counter
Write-Host ""
Write-Host "🔢 Initializing visitor counter in DynamoDB..." -ForegroundColor Yellow
aws dynamodb put-item `
    --table-name Visitors `
    --item '{\"id\": {\"S\": \"counter\"}, \"visits\": {\"N\": \"0\"}}' `
    --return-consumed-capacity TOTAL 2>$null

Write-Host ""
Write-Host "✅ Deployment complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Your website is now live at:" -ForegroundColor Cyan
Write-Host "   $CLOUDFRONT_URL" -ForegroundColor White
Write-Host ""
Write-Host "🔗 API Endpoint:" -ForegroundColor Cyan
Write-Host "   $API_URL" -ForegroundColor White
Write-Host ""
Write-Host "⏳ Note: CloudFront distribution may take 10-15 minutes to fully propagate." -ForegroundColor Yellow