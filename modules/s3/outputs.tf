output "bucket_regional_domain_name" {
    value = aws_s3_bucket.static_website_sebu_test.bucket_regional_domain_name
}

output "cloudfront_arn" {
    value = aws_cloudfront_distribution.s3_distribution.arn
}

output "cloudfront_id" {
    value = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_oai" {
    value = aws_cloudfront_origin_access_control.sebu_test_oac.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
