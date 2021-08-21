variable "owner" {
  type        = string
  default     = "sre-aircall"
  description = "Identifies who is responsible for the resource"
}

variable "service_name" {
  type        = string
  default     = "leonardo-resize-image"
  description = "Identify the service name, this is likely the same as the repo name"
}

variable "envname" {
  type        = string
  default     = "test"
  description = "Used to identify resource farms that share a common configuration and perform a specific function for an application. Descriptive environment name, ie. loadtest, test1, test2, bob."
}

variable "managed_by" {
  type        = string
  default     = "Terraform"
  description = "Used to describe how resources are managed"
}

variable "versioning" {
  type        = string
  default     = "v1.0.0"
  description = "The version of the service"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Runtime Node"
  type        = string
  default     = "nodejs14.x"
}

variable "filename_module" {
  description = "Module nodejs"
  type        = string
  default     = "/tmp/node_modules.zip"
}

variable "filename_codebase" {
  description = "codebase nodejs"
  type        = string
  default     = "/tmp/code.zip"
}