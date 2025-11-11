import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart'; // import trang đăng nhập

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F51B5),
        elevation: 0,
        title: const Text(
          'Cá nhân',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.white,
            ),
          ),
        ],
      ),

      // Nội dung chính
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Card thông tin người dùng
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.blue.shade50,
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.blueAccent,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Nguyễn Hoài Nam',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(CupertinoIcons.exclamationmark_circle,
                                size: 16, color: Colors.orange),
                            SizedBox(width: 4),
                            Text(
                              'Đoàn viên chưa xác thực',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(CupertinoIcons.exclamationmark_circle,
                                size: 16, color: Colors.orange),
                            SizedBox(width: 4),
                            Text(
                              'Cán bộ Đoàn chưa xác thực',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.pencil_circle_fill,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Các menu
            _buildMenuSection([
              _buildMenuItem(CupertinoIcons.info_circle, 'Thông tin Đoàn viên', () {}),
              _buildMenuItem(CupertinoIcons.person_2, 'Thông tin Cán bộ Đoàn', () {}),
              _buildMenuItem(CupertinoIcons.qrcode_viewfinder, 'Quét mã QR', () {}),
              _buildMenuItem(CupertinoIcons.time, 'Lịch sử check-in', () {}),
            ]),

            _buildMenuSection([
              _buildMenuItem(CupertinoIcons.settings, 'Cài đặt', () {}),
              _buildMenuItem(CupertinoIcons.doc_text, 'Điều khoản sử dụng', () {}),
              _buildMenuItem(CupertinoIcons.lock_shield, 'Chính sách bảo vệ DLCN', () {}),
            ]),

            _buildMenuSection([
              _buildMenuItem(CupertinoIcons.info, 'Thông tin ứng dụng', () {}),
              _buildMenuItem(
                CupertinoIcons.square_arrow_right,
                'Đăng xuất',
                () => _showLogoutDialog(context),
              ),
            ]),

            const SizedBox(height: 30),
            const Text(
              'Phiên bản ứng dụng 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // === Các widget con ===

  Widget _buildMenuSection(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent, size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: const Icon(CupertinoIcons.chevron_forward, size: 18),
      onTap: onTap,
    );
  }

  // === Hàm hiển thị hộp thoại xác nhận đăng xuất ===
  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Xác nhận đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất khỏi ứng dụng không?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Hủy'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Đăng xuất'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
