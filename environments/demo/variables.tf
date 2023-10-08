variable "tags" {
  type = map(string)
  default = {
    managed-by = "terraform"
  }
}