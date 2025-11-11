import 'package:flutter/material.dart';

class CanBoDoanHomeScreen extends StatelessWidget {
  const CanBoDoanHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trang chủ Cán bộ Đoàn",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF004AAD), // Màu xanh chủ đạo
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F0FE), Color(0xFFF7F9FF)], // Nền nhẹ
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_alt_outlined,
                size: 80,
                color: Color(0xFF004AAD),
              ),
              SizedBox(height: 16),
              Text(
                "Xin chào Cán bộ Đoàn!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Quản lý hoạt động, sự kiện và đoàn viên.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF555555),
                ),
              ),
              // Các chức năng Cán bộ Đoàn sẽ được thêm tại đây
            ],
          ),
        ),
      ),
    );
  }
}