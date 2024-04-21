variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"

  validation {
    condition     = length(var.resource_group_name) <= 30
    error_message = "The resource group name must be less than 30 characters"
  }
}
