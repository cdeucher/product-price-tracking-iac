resource "aws_s3_bucket" "devops_app_bucket" {
  bucket = "devops-app-bucket-${var.env_name}"

  tags = merge({ Name  = "devops-app-${var.env_name}" }, var.tags)
}

resource "aws_s3_bucket_acl" "acl" {
  bucket  = aws_s3_bucket.devops_app_bucket.id
  acl     = "private"
}

resource "aws_s3_bucket_cors_configuration" "cors" {
  bucket = aws_s3_bucket.devops_app_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_object" "current" {
  bucket        = aws_s3_bucket.devops_app_bucket.id
  content_type  = "application/x-directory"
  key           = "app/"
}

resource "aws_s3_object" "static_sync" {
  for_each = toset([ for fn in fileset("${path.module}/${var.src_path}", "**/*") : fn if length(regexall("^logotypes\\/r12n\\/[0-9]{14}\\.jpg$", fn)) == 0 ])

  bucket = aws_s3_bucket.devops_app_bucket.id
  key    = "app/${each.value}"
  source = "${path.module}/${var.src_path}/${each.value}"
  etag   = filemd5("${path.module}/${var.src_path}/${each.value}")

  content_type = "%{ if contains(["jpeg", ".jpg"], strrev(substr(strrev(each.value), 0, 4))) }image/jpeg%{ endif }%{ if contains(["png"], strrev(substr(strrev(each.value), 0, 3))) }image/png%{ endif }%{ if contains(["json"], strrev(substr(strrev(each.value), 0, 4))) }application/json%{ endif }%{ if contains(["apple-app-site-association"], strrev(substr(strrev(each.value), 0, 26))) }application/json%{ endif }%{ if contains(["html"], strrev(substr(strrev(each.value), 0, 4))) }text/html%{ endif }%{ if contains(["js"], strrev(substr(strrev(each.value), 0, 2))) }text/javascript%{ endif }%{ if contains(["css"], strrev(substr(strrev(each.value), 0, 3))) }text/css%{ endif }%{ if contains(["csv"], strrev(substr(strrev(each.value), 0, 3))) }text/csv%{ endif }"
}


resource "aws_s3_bucket_public_access_block" "devops_app_access_block" {
  bucket = aws_s3_bucket.devops_app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

data "aws_iam_policy_document" "devops_app_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.devops_app_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.devops_app_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "devops_app_bucket_policy" {
  bucket = aws_s3_bucket.devops_app_bucket.id
  policy = data.aws_iam_policy_document.devops_app_policy_document.json
}
