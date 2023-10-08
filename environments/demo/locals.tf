locals {
  tags = merge(var.tags, {
    environment = "demo"
  })

  buckets = {
    gerard-rocks = {}
    gerard-really-rocks = {
      enable_versioning = false
    }
  }
}