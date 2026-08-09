output "vps_public_ip" {
  description = "Địa chỉ IP máy chủ VPS sau khi khởi tạo thành công"
  value       = aws_instance.vps_server.public_ip
}
