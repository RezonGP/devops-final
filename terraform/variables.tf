variable "aws_region" {
  description = "Khu vực đặt máy chủ AWS (Singapore)"
  type        = string
  default     = "ap-southeast-1"
}

variable "instance_type" {
  description = "Cấu hình VPS (Gói Free Tier)"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Tên SSH Key để truy cập VPS"
  type        = string
  default     = "devops-key"
}
