data "aws_iam_policy_document" "website_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
    principals {
      //specifies the user, account, service, or other entity that is allowed or denied access to a resource
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
      //type = "AWS"
      //identifiers = [aws_cloudfront_distribution.s3_distribution.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"]
    }
  }
}

// COMENTADO PARA PRUEBA
/*data "aws_iam_policy_document" "website_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      //specifies the user, account, service, or other entity that is allowed or denied access to a resource
      identifiers = [*]
      type = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}*/