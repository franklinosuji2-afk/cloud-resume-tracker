provider "aws" {
  region = var.region
}

resource "aws_dynamodb_table" "visitors" {
  name           = "Visitors"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

output "dynamodb_table" {
  value = aws_dynamodb_table.visitors.name
}
