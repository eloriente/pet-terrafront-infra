module "s3" {
  source = "./modules/s3"

  bucket_name = "sqt-${var.project_name}-bucket"
}

module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_name = module.s3.bucket_name
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  origin_access_control_id = "oca-id-${var.project_name}"
  cf_distribution_comment = "CloudFront distribution for ${var.project_name}"
}