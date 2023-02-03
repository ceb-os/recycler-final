resource "aws_s3_bucket" "static_website_sebu_test" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "sebu_test_acl" {
  bucket = var.bucket_name
  acl    = "private"
  //acl    = "public-read"
}

resource "aws_s3_bucket_policy" "public_access" {
    bucket = aws_s3_bucket.static_website_sebu_test.id
    policy = data.aws_iam_policy_document.website_policy.json
}

// COMENTADO PARA PRUEBA
/*resource "aws_s3_bucket_website_configuration" "static_website_config" {
    bucket = var.bucket_name
    index_document {
      suffix = "index.html"
    }
}*/