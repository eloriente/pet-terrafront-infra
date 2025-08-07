locals {
  cf_arn = aws_cloudfront_distribution.s3_distribution.arn
}

output "cf_distribution_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_arn" {
  value = local.cf_arn
}