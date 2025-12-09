variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for hosting the resume website"
  type        = string
  default     = "cloud-resume-tracker-website"
}
