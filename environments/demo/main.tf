module "s3_bucket" {
  source = "../../modules/s3"

  for_each = local.buckets

  bucket            = each.key
  enable_versioning = lookup(each.value, "enable_versioning", "true")
  tags              = local.tags
}
