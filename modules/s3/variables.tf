variable "bucket" {
  default = "blah"
  type    = string
}
variable "bucket_prefix" {
  default = null
  type    = string
}
variable "create_bucket" {
  default = "true"
  type    = bool
}
variable "enable_encryption" {
  default = "true"
  type    = bool
}
variable "enable_versioning" {
  default = "true"
  type    = bool
}
variable "enable_logging" {
  default = "true"
  type    = bool
}
variable "force_destroy" {
  default = "false"
  type    = string
}
variable "object_lock_enabled" {
  default = "false"
  type    = string
}
variable "tags" {
  type = map(string)
  default = {
    managed-by = "terraform"
  }
}