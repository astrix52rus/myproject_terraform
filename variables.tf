variable "ssh_key_id" {
  type      = string
  sensitive = true
}

variable "email" {
  type = string
}

variable "task" {
  type = string
}

variable "token" {
  type      = string
  sensitive = true
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}

variable "count1" {
  type = number
}

variable "pass_for_dr" {
  type      = string
}

variable "path" {
  type = string
}

variable "dev" {
  type = list(object({
    prefix     = string
    your_login = string
  }))
}

variable "path_to_info" {
  type      = string
}
