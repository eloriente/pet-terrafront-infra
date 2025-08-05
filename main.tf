module "s3" {
  source = "./modules/s3"
  bucket_name = "sqt-${var.project_name}-${var.env}-bucket"
}

module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_name = module.s3.bucket_name
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  origin_access_control_id = "oca-id-${var.project_name}-${var.env}"
  cf_distribution_comment = "${var.project_name}-${var.env}"

  depends_on = [module.s3]
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = module.s3.bucket_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontRead",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "arn:aws:s3:::${module.s3.bucket_name}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.cloudfront_distribution_arn
          }
        }
      }
    ]
  })

  depends_on = [module.cloudfront]
}