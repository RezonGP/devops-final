# 🚀 DEVOPS FINAL PROJECT - TODO LIST APPLICATION
> **Khóa học DevOps Specialist - Cybersoft Academy**  
> **Họ và tên Học viên:** Trần Nam Phong  
> **GitHub Repository:** [https://github.com/RezonGP/devops-final](https://github.com/RezonGP/devops-final)

---

## 📐 1. SƠ ĐỒ KIẾN TRÚC HỆ THỐNG (SYSTEM ARCHITECTURE)

Dự án được xây dựng theo kiến trúc **3-Tier microservices** chuẩn doanh nghiệp, được đóng gói hoàn toàn bằng **Docker** và giám sát tự động bằng **Prometheus & Grafana**:

```text
                               ┌──────────────────────────────────────────────┐
                               │                 INTERNET                     │
                               └──────────────────────┬───────────────────────┘
                                                      │
                                                      ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                       DOCKER COMPOSE STACK                                      │
│                                                                                                 │
│    ┌──────────────────────────┐      proxy_pass      ┌──────────────────────────┐               │
│    │    Frontend Container    │ ────────────────────►│    Backend Container     │               │
│    │  (ReactJS + Nginx:80)    │                      │   (NodeJS Express:8000)  │               │
│    └──────────────────────────┘                      └────────────┬─────────────┘               │
│                                                                   │                             │
│                                                                   ▼                             │
│    ┌──────────────────────────┐                      ┌──────────────────────────┐               │
│    │   MongoDB Exporter:9216  │ ────────────────────►│     MongoDB Container    │               │
│    └────────────┬─────────────┘                      │     (Database:27017)     │               │
│                 │                                    └──────────────────────────┘               │
│                 │ Scrape                                                                        │
│                 ▼                                                                               │
│    ┌──────────────────────────┐                      ┌──────────────────────────┐               │
│    │   Prometheus Container   │ ◄─────────────────── │   Node Exporter:9100     │               │
│    │       (Port: 9090)       │       Scrape         │  (System Hardware Metrics│               │
│    └────────────┬─────────────┘                      └──────────────────────────┘               │
│                 │                                                                               │
│                 ▼ Query Metrics                                                                 │
│    ┌──────────────────────────┐                                                                 │
│    │    Grafana Container     │ (Live Dashboards: CPU, RAM, Disk, Traffic & MongoDB)            │
│    │       (Port: 3000)       │                                                                 │
│    └──────────────────────────┘                                                                 │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ 2. CÁC CỔNG DỊCH VỤ (PORT MAPPING TABLE)

| Dịch vụ (Service) | Container Name | Cổng Port Host | Mô tả chức năng |
| :--- | :--- | :---: | :--- |
| **Frontend Web** | `todo-frontend` | `80` | Giao diện ReactJS được phục vụ qua Nginx Reverse Proxy |
| **Backend API** | `todo-backend` | `8000` | RESTful API ExpressJS xử lý logic nghiệp vụ & Authentication |
| **MongoDB** | `todo-mongodb` | `27017` | Cơ sở dữ liệu chính lưu trữ User & Todo Tasks |
| **Prometheus** | `todo-prometheus` | `9090` | Thu thập & lưu trữ Time-Series Metrics từ các Exporter |
| **Grafana** | `todo-grafana` | `3000` | Trực quan hóa dữ liệu giám sát sức khỏe VPS theo thời gian thực |
| **Node Exporter** | `todo-node-exporter` | `9100` | Quét thông số phần cứng (CPU, RAM, Disk, Network) |
| **MongoDB Exporter**| `todo-mongodb-exporter` | `9216` | Quét chỉ số hiệu năng và kết nối của MongoDB |

---

## ⚡ 3. HƯỚNG DẪN KHỞI CHẠY DỰ ÁN TẠI LOCALHOST

### Yêu cầu môi trường:
- Đã cài đặt **Docker Desktop** (hoặc Docker Engine & Docker Compose v2).

### Các bước khởi chạy:
1. Clone dự án từ GitHub:
   ```bash
   git clone https://github.com/RezonGP/devops-final.git
   cd devops-final
   ```

2. Khởi chạy toàn bộ 7 dịch vụ chỉ bằng 1 câu lệnh:
   ```bash
   docker compose up --build -d
   ```

3. Truy cập kiểm tra trên trình duyệt:
   - **Frontend App**: `http://localhost`
   - **Backend Health Check**: `http://localhost:8000/api/task`
   - **Prometheus Dashboard**: `http://localhost:9090/targets`
   - **Grafana Dashboard**: `http://localhost:3000` *(Tài khoản: `admin` / Mật khẩu: `admin`)*

---

## 🌐 4. QUẢN LÝ HẠ TẦNG CLOUD BẰNG TERRAFORM (IaC)

Thư mục `terraform/` chứa toàn bộ mã nguồn tự động khởi tạo hạ tầng VPS trên **AWS EC2**:

- **[terraform/variables.tf](file:///c:/Users/pnam0/OneDrive/Máy tính/devops-final-project/terraform/variables.tf)**: Khai báo biến Region (`ap-southeast-1` Singapore), gói phần cứng `t2.micro` và Key Pair `phong-aws`.
- **[terraform/main.tf](file:///c:/Users/pnam0/OneDrive/Máy tính/devops-final-project/terraform/main.tf)**: Khai báo AWS Provider, tự động mở Security Group (các cổng 22, 80, 8000, 3000, 9090), chọn Ubuntu 22.04 LTS và tạo EC2 Instance.
- **[terraform/outputs.tf](file:///c:/Users/pnam0/OneDrive/Máy tính/devops-final-project/terraform/outputs.tf)**: Tự động in ra địa chỉ IP Public của máy chủ VPS sau khi khởi tạo thành công.

### Lệnh kiểm tra cú pháp Terraform:
```bash
cd terraform
terraform init
terraform validate
```

---

## 🚚 5. CẤU HÌNH TỰ ĐỘNG HÓA BẰNG ANSIBLE

Thư mục `ansible/` chứa kịch bản tự động cấu hình và triển khai dự án lên VPS:

- **[ansible/inventory.ini](file:///c:/Users/pnam0/OneDrive/Máy tính/devops-final-project/ansible/inventory.ini)**: Khai báo IP máy chủ VPS và đường dẫn chìa khóa SSH (`~/.ssh/phong-aws.pem`).
- **[ansible/playbook.yml](file:///c:/Users/pnam0/OneDrive/Máy tính/devops-final-project/ansible/playbook.yml)**: Kịch bản 5 bước tự động hóa:
  1. Cập nhật hệ thống Ubuntu & cài đặt Git.
  2. Cài đặt Docker Engine.
  3. Bật dịch vụ Docker tự khởi chạy cùng hệ thống.
  4. Pull mã nguồn mới nhất từ kho GitHub `RezonGP/devops-final.git`.
  5. Khởi chạy toàn bộ hệ thống bằng lệnh `docker compose up --build -d`.

### Lệnh kiểm tra kịch bản Ansible:
```bash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --syntax-check
```

---

## 🔄 6. TỰ ĐỘNG HÓA TRIỂN KHAI CI/CD PIPELINE

Dự án hỗ trợ cả 2 công cụ CI/CD hàng đầu hiện nay:

### 1. GitHub Actions Workflows (`.github/workflows/deploy.yml`)
- Tự động kích hoạt mỗi khi có lượt `git push` lên nhánh `main`.
- Tự động Build Docker Image và kết nối SSH sang máy chủ VPS để Deploy bản cập nhật mới nhất.

### 2. Jenkins Pipeline (`Jenkinsfile`)
- Quy trình 3 giai đoạn: `Checkout Code` ➔ `Build Docker Images` ➔ `Deploy Application`.
- Tự động in ra báo cáo trạng thái thành công/thất bại qua khối `post`.

---

## 🏆 ĐÁNH GIÁ MỤC TIÊU HOÀN THÀNH

- [x] Đóng gói Backend Node.js Express với Dockerfile.
- [x] Đóng gói Frontend ReactJS với Multi-stage build & Nginx Reverse Proxy.
- [x] Thống nhất hạ tầng Fullstack 7 dịch vụ qua Docker Compose.
- [x] Cài đặt hệ thống giám sát Prometheus & Grafana với Auto-provisioning.
- [x] Tự động hóa tạo hạ tầng AWS Cloud bằng Terraform (IaC).
- [x] Tự động hóa cài đặt môi trường & Deploy bằng Ansible Playbook.
- [x] Thiết lập đường ống CI/CD tự động bằng GitHub Actions & Jenkins.
