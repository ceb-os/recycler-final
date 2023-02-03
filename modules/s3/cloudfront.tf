resource "aws_cloudfront_origin_access_control" "sebu_test_oac" {
  name                              = "sebu test oac"
  description                       = "connect cloudfront to recycler's s3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
resource "aws_cloudfront_distribution" "s3_distribution" {

// ------------------------------- ORIGIN SETTINGS --------------------------------
// -------------------------------------REQUIRED-----------------------------------
//where you store the original versions of your web content
  origin {
    //regional bucket domain name (http://bucket-name.s3-website-Region.amazonaws.com)
    domain_name = aws_s3_bucket.static_website_sebu_test.bucket_regional_domain_name
    origin_id   = "uber_recycler_bucket"
    origin_access_control_id = aws_cloudfront_origin_access_control.sebu_test_oac.id
  }

// ----------------------------- DISTRIBUTION SETTINGS ----------------------------
// -------------------------------------REQUIRED-----------------------------------
//CloudFront accepts and handles any end-user requests for content that
//use the domain name associated with that distribution.
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

//If the distribution doesn't use Aliases, that is,
//if the distribution uses the CloudFront domain name such as 
//d111111abcdef8.cloudfront.net, set CloudFrontDefaultCertificate to true
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  price_class = "PriceClass_200"
  // ----------------------------- CACHE BEHAVIOR SETTINGS --------------------------
// -------------------------------------REQUIRED-----------------------------------
//lets you configure a variety of CloudFront functionality
//for a given URL path pattern for files on your website.

  default_cache_behavior {
    //ID for the origin that you want CloudFront to route 
    //requests to when a request matches the path pattern
    target_origin_id = "uber_recycler_bucket"
    //HTTP methods that you want CloudFront to process and forward to your origin
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    //cache the response from your origin when a viewer submits an OPTIONS request.
    //CloudFront always caches the response to GET and HEAD requests.
    cached_methods   = ["GET", "HEAD"]
    //specifies which requests you want this cache behavior to apply to.
    //it is * and CANNOT BE CHANGED
    //path_pattern = "/content/*"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  //viewer_protocol_policy = "allow-all"
  viewer_protocol_policy = "https-only"
      min_ttl                = 0
      default_ttl            = 3600
      max_ttl                = 86400
  }

// ----------------------------- GEOGRAPHIC RESTRICTIONS --------------------------
// -------------------------------------REQUIRED-----------------------------------
//If you need to prevent users in selected countries from accessing your content
  restrictions {
    geo_restriction {
      //if you want CloudFront to distribute your content set whitelist, 
      //if you want to not distribute set blacklist
      restriction_type = "whitelist"
      locations        = ["AR", "BR", "US"]
      //locations        = ["US", "CA", "GB", "IN"]
    }
  }
}


/*
# Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "my_first_origin"
forwarded_values {
      query_string = false
      headers      = ["Origin"]
cookies {
        forward = "none"
      }
    }
min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "allow-all"
  }
# Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id  = "my_first_origin"
forwarded_values {
      query_string = false
cookies {
        forward = "none"
      }
    }
min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress             = true
    viewer_protocol_policy = "redirect-to-https"
  }


}*/