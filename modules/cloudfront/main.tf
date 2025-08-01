resource "aws_cloudfront_origin_access_control" "origin_access_control" {
  name                              = var.origin_access_control_id
  description                       = "Origin Control Access - ${var.origin_access_control_id}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = var.s3_bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin_access_control.id
    origin_id                = var.bucket_name
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.cf_distribution_comment
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name
    cache_policy_id  = data.aws_cloudfront_cache_policy.managed_caching_optimized_policy.id

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }


  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_cloudfront_cache_policy" "managed_caching_optimized_policy" {
  name = "Managed-CachingOptimized"
}