# Simple S3 Module

Simple S3 module to manage bucket creation with options for logging, encryption, tagging, and versioning. 

## What's Included

Simple S3 module with some toggles, and a sample environment with usage. 

## Usage

### Option 1 - Call the Module Creating Multiple Buckets

Using the **for_each** argument to define a map of buckets to be created:

```hcl
module "s3_bucket" {
  source = "../../modules/s3"

  for_each = local.buckets

  bucket            = each.key
  enable_versioning = lookup(each.value, "enable_versioning", "true")
  tags              = local.tags
}
```

To add the map, you can rely mostly on defaults. However, for demonstration purposes, we'll disable versioning on the "gerard-really-rocks" bucket. The "gerard-rocks" bucket will be created with defaults.

```hcl
  buckets = {
    gerard-rocks = {}
    gerard-really-rocks = {
      enable_versioning = false
    }
  }
```  

### Option 2 - Creating a Single Bucket with Default Values

```hcl
module "s3_bucket" {
  source = "../../modules/s3"

  bucket = "single_bucket"
}
```

