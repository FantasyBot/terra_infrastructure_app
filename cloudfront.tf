# CloudFront Distribution for React App
resource "aws_cloudfront_distribution" "react_app_distribution" {
  origin {
    domain_name = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.frontend_bucket.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "index.html"

  # Default Cache Behavior
  default_cache_behavior {
    target_origin_id = aws_s3_bucket.frontend_bucket.id

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS",
      "PUT",
      "POST",
      "PATCH",
      "DELETE",
    ]

    cached_methods = [
      "GET",
      "HEAD",
    ]

    # Cache settings
    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }

      headers = [
        "Origin",
        "Authorization"
      ]
    }

    min_ttl     = 0
    default_ttl = 86400    # 1 day
    max_ttl     = 31536000 # 1 year
  }

  # Viewer Certificate for HTTPS
  viewer_certificate {
    cloudfront_default_certificate = true
    # For custom domains, use:
    # acm_certificate_arn = "your_acm_certificate_arn"
    # ssl_support_method = "sni-only"
  }

  # # Logging Configuration
  # logging_config {
  #   bucket          = aws_s3_bucket.cloudfront_logs_bucket.bucket_regional_domain_name
  #   include_cookies = false              # Set to true if you want to log cookies
  #   prefix          = "cloudfront-logs/" # Prefix for log files
  # }

  # Restrictions (optional)
  restrictions {
    geo_restriction {
      restriction_type = "none" # Change to "whitelist" or "blacklist" if needed
    }
  }

  # Price Class (optional)
  price_class = "PriceClass_100" # Change to PriceClass_200 or PriceClass_All as needed

  # Comment
  comment = "CloudFront distribution for my React app"
}
