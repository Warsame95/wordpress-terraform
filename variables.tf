variable "vpc_id" {
  type = string
}

variable "instance_id" {
  type = string
}

variable "instance_type" {
  type = string
}

# variable "pub_subnet_id" {
#   type = string
# }

 variable "igw_gateway_id" {
   type = string
}

 variable "nat_gateway_id" {
   type = string
 }

variable "http_port" {
  description = "Port for HTTP access"
  type        = number
  default     = 80
}

variable "ssh_port" {
  description = "Port for SSH access"
  type        = number
  default     = 22
}

variable "http_cidr" {
  description = "Allowed CIDR block for HTTP"
  type        = string
  default     = "0.0.0.0/0"
}

variable "http_ssh" {
  description = "Allowed CIDR block for SSH"
  type        = string
  default     = "0.0.0.0/0"
}
