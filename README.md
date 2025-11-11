<h2 align="center">
    <a href="https://dainam.edu.vn/vi/khoa-cong-nghe-thong-tin">
    🎓 Faculty of Information Technology (DaiNam University)
    </a>
</h2>
<h2 align="center">
 
</h2>
<div align="center">
    <p align="center">
        <img src="docs/aiotlab_logo.png" alt="AIoTLab Logo" width="170"/>
        <img src="docs/fitdnu_logo.png" alt="AIoTLab Logo" width="180"/>
        <img src="docs/dnu_logo.png" alt="DaiNam University Logo" width="200"/>
    </p>

[![AIoTLab](https://img.shields.io/badge/AIoTLab-green?style=for-the-badge)](https://www.facebook.com/DNUAIoTLab)
[![Faculty of Information Technology](https://img.shields.io/badge/Faculty%20of%20Information%20Technology-blue?style=for-the-badge)](https://dainam.edu.vn/vi/khoa-cong-nghe-thong-tin)
[![DaiNam University](https://img.shields.io/badge/DaiNam%20University-orange?style=for-the-badge)](https://dainam.edu.vn)


<h1 align="center">📱 ỨNG DỤNG QUẢN LÝ CÔNG ĐOÀN KHOA CÔNG NGHỆ THÔNG TIN</h1>
</div>

---

## 📖 1. Giới thiệu

Ứng dụng **Quản lý Công đoàn Khoa CNTT** được phát triển bằng **Flutter (Mobile)** và **Node.js (Server)**, hỗ trợ quản lý đoàn viên, hoạt động, quỹ công đoàn và thống kê trực quan.  
Hệ thống cho phép **Ban Chấp hành Công đoàn** và **Đoàn viên** theo dõi, cập nhật, tham gia và quản lý mọi hoạt động công đoàn nhanh chóng và hiệu quả.

Trong mô hình này:

- **Client (Flutter)**: Giao diện người dùng trên di động, thân thiện và dễ sử dụng.  
- **Server (Node.js)**: Xử lý logic, lưu trữ dữ liệu, xác thực người dùng qua REST API.  

---

### 📊 Mục tiêu của đề tài

- Phát triển ứng dụng mobile hỗ trợ **quản lý đoàn viên** và **hoạt động công đoàn**.  
- Số hóa quy trình quản lý, thống kê và khen thưởng.  
- Hỗ trợ phân quyền (Admin / User).  
- Lưu trữ dữ liệu trên **PostgreSQL** hoặc **MongoDB**.  
- Bảo mật với **JWT**, mã hóa mật khẩu bằng **bcrypt**.  

---

## 🔧 2. Công nghệ sử dụng

### 📱 **Frontend (Flutter)**
- **Flutter 3.22+**, **Dart**
- Giao diện: `Material UI`, `Provider`, `HTTP`, `Shared Preferences`, `Charts`
- Tích hợp API RESTful
- Biểu đồ và thống kê bằng `charts_flutter`
- Lưu token bảo mật với `flutter_secure_storage`

### 🌐 **Backend (Node.js + Express)**
- **Node.js 20+**, **Express.js**
- **PostgreSQL / MongoDB**: lưu trữ dữ liệu
- **JWT**: xác thực người dùng
- **bcrypt.js**: mã hóa mật khẩu
- **Multer**: upload ảnh hoặc tài liệu
- **Cors / Helmet**: tăng cường bảo mật

---

## 🖼️ 3. Hình ảnh chức năng

<p align="center">
  <img src="docs/login.jpg" alt="Login Screen" width="250"/>
  <img src="docs/dashboard.jpg" alt="Dashboard" width="250"/>
  <img src="docs/events.jpg" alt="Events" width="250"/>
</p>
<p align="center"><em>Hình 1: Giao diện đăng nhập – trang chủ – hoạt động công đoàn</em></p>

<p align="center">
  <img src="docs/members.jpg" alt="Members" width="250"/>
  <img src="docs/funds.jpg" alt="Funds" width="250"/>
  <img src="docs/stats.jpg" alt="Statistics" width="250"/>
</p>
<p align="center"><em>Hình 2: Quản lý đoàn viên – quỹ – thống kê</em></p>

---

## ⚙️ 4. Các bước cài đặt

### 🔹 Bước 1 Chuẩn bị môi trường
```bash
# Cài đặt thư viện
npm node -v
npm -v

# Cấu hình biến môi trường
cp .env.example .env
# Chỉnh sửa DATABASE_URL, JWT_SECRET,...
```
### 🔹 Bước 2 Cấu hình backend
```
cp .env.example .env
npm install

```
### 🔹 Bước 3 Cấu hình frontend
```
const String BASE_URL = "http://localhost:3000";
flutter pub get
```
### 🔹 Bước 4 Chạy ứng dụng

```
flutter run
flutter build apk      # Android
flutter build ios      # iOS
flutter build web      # Web
```
## 📞5. Liên hệ
Nếu bạn có bất kỳ thắc mắc hoặc cần hỗ trợ về dự án vui lòng liên hệ:  

- 👨‍🎓 **Sinh viên thực hiện**: Nguyễn Hoài Nam 
- 🎓 **Khoa**: Công nghệ thông tin – Trường Đại học Đại Nam  
- 📧 **Email**: Hoainam2655@gmail.com




