resource "aws_s3_bucket" "this" {
  count = var.create_bucket ? 1 : 0

  bucket = var.bucket

  bucket_prefix       = var.bucket_prefix
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = var.enable_encryption ? 1 : 0

  bucket = aws_s3_bucket.this[count.index].id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this.id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_kms_key" "this" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_versioning" "this" {
  count = var.enable_versioning ? 1 : 0

  bucket = aws_s3_bucket.this[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "log_bucket" {
  count = var.enable_logging ? 1 : 0

  bucket = "${aws_s3_bucket.this[count.index].bucket}-logs"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  count = var.enable_logging ? 1 : 0

  bucket = aws_s3_bucket.log_bucket[count.index].id

  acl        = "log-delivery-write"
  depends_on = [aws_s3_bucket_ownership_controls.log_bucket]

}

resource "aws_s3_bucket_ownership_controls" "log_bucket" {
  count = var.enable_logging ? 1 : 0

  bucket = aws_s3_bucket.log_bucket[count.index].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_logging" "example" {
  count = var.enable_logging ? 1 : 0

  bucket        = aws_s3_bucket.this[count.index].id
  target_bucket = aws_s3_bucket.log_bucket[count.index].id
  target_prefix = "log/"
}