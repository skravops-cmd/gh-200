variable "name" {
  type = string
}

variable "image" {
  type = string
}

variable "env_vars" {
  type    = map(string)
  default = {}
}

variable "ports" {
  type    = list(string)
  default = []
}

variable "networks" {
  type    = list(string)
  default = []
}

locals {
  internal_port = length(var.ports) > 0 ? tonumber(split(":", var.ports[0])[1]) : null
  external_port = length(var.ports) > 0 ? tonumber(split(":", var.ports[0])[0]) : null
}
