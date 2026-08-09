# Kế hoạch triển khai Dự án cuối khóa DevOps (Cybersoft)

Tài liệu này tóm tắt yêu cầu từ đề bài dự án cuối khóa Cybersoft và phác thảo chi tiết toàn bộ các bước triển khai từ đầu đến cuối (Localhost -> Docker Container -> Terraform Provisioning -> Ansible Automation -> CI/CD Deployments -> Prometheus & Grafana Monitoring).

---

## 1. Tóm tắt Yêu cầu Đề bài (Cybersoft DevOps Final Project)

- **Ứng dụng mẫu**: Todo List fullstack (Frontend ReactJS + Backend ExpressJS + Database MongoDB).
- **Yêu cầu kỹ thuật chính**:
  1. **Docker & Docker Compose**: Đóng gói `backend` và `frontend` bằng `Dockerfile` (multi-stage cho React với Nginx), thiết lập `docker-compose.yml` chạy đồng thời Frontend, Backend, MongoDB (và exporter).
  2. **Terraform**: Viết script Terraform tự động khởi tạo hạ tầng VPS (VPC, Subnet, Security Group, EC2 Instance/Cloud VPS).
  3. **Ansible**: Viết Ansible Playbook cài đặt Docker, Docker Compose, cấu hình môi trường và tự động deploy ứng dụng trên VPS.
  4. **Giám sát (Monitoring)**: Cài đặt Prometheus & Grafana để theo dõi thông số VPS (cpu, ram, disk) và trạng thái MongoDB (MongoDB Exporter / Node Exporter).
  5. **CI/CD Pipeline**: Viết script tự động hóa deploy bằng cả **GitHub Actions** (`.github/workflows/deploy.yml`) và **Jenkins** (`Jenkinsfile`).
- **Điểm cộng**: Thuê VPS / Domain thật & làm video demo trình bày.

---

## 2. Quy trình Thực hiện Chi tiết từ A - Z (Roadmap 6 Giai đoạn)

1. **Giai đoạn 1**: Chạy & kiểm tra Localhost (Node.js + React + MongoDB local).
2. **Giai đoạn 2**: Đóng gói Dockerfile (`frontend`, `backend`) & Docker Compose cho toàn bộ stack ứng dụng + exporter.
3. **Giai đoạn 3**: Viết Terraform Scripts khởi tạo hạ tầng VPS (AWS EC2 / Cloud VPS).
4. **Giai đoạn 4**: Viết Ansible Playbook cài đặt Docker, Git & deploy tự động trên VPS.
5. **Giai đoạn 5**: Cấu hình Hệ thống Giám sát Monitoring (Prometheus + Grafana + Node Exporter + MongoDB Exporter).
6. **Giai đoạn 6**: Xây dựng CI/CD Pipeline (GitHub Actions & Jenkins).

---

## User Review Required

> [!IMPORTANT]
> - **Cloud Provider**: Kế hoạch chuẩn bị script Terraform cho AWS EC2 (hoặc DigitalOcean/Linode tùy theo tài khoản bạn có). Bạn hãy xác nhận Cloud Provider bạn muốn dùng hoặc nếu đã có VPS tạo sẵn.
> - **Chạy thử local**: Bạn đã cài sẵn Docker Desktop trên máy tính Windows chưa?

---

## Open Questions

> [!NOTE]
> 1. Bạn muốn chạy thử từng bước cùng mình (ví dụ: Tạo Dockerfile trước, test Compose local rồi mới sang Terraform/Ansible) hay muốn tạo toàn bộ file cấu hình hoàn chỉnh ngay?
> 2. Bạn dự định sẽ nộp dự án bằng AWS EC2 (Free Tier) hay loại VPS nào khác?
