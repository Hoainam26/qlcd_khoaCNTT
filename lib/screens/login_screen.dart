import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'CanBoDoanHome_Screen.dart';
import 'AdminHome_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  // --- Định nghĩa Hằng số Màu sắc và UI ---
  static const Color _primaryBlue = Color(0xFF004AAD); // Màu chính của Đoàn
  static const Color _primaryRed = Color(0xFFDC143C); // Màu nhấn/Admin
  static const Color _inputHintColor = Colors.grey;

  // Định nghĩa const cho BorderRadius.only để tái sử dụng
  static const _inputBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );

  // Định nghĩa const cho OutlineInputBorder mặc định (Blue theme)
  static const _outlineInputBorder = OutlineInputBorder(
    borderRadius: _inputBorderRadius,
    borderSide: BorderSide(color: _inputHintColor),
  );
  
  static const _focusedBlueOutlineInputBorder = OutlineInputBorder(
    borderRadius: _inputBorderRadius,
    borderSide: BorderSide(color: _primaryBlue, width: 2),
  );

  // Định nghĩa const cho OutlineInputBorder Admin (Red theme)
  static const _focusedRedOutlineInputBorder = OutlineInputBorder(
    borderRadius: _inputBorderRadius,
    borderSide: BorderSide(color: _primaryRed, width: 2),
  );

  // Danh sách các vai trò để hiển thị trên TabBar
  final List<String> _tabs = const ['Đoàn viên', 'Cán bộ Đoàn', 'Admin'];

  // Tab Controller
  late TabController _tabController;

  // Controllers cho các trường nhập liệu
  final TextEditingController _studentIdController = TextEditingController(); // Đoàn viên
  final TextEditingController _officerUserController = TextEditingController(); // Cán bộ Đoàn TK
  final TextEditingController _officerPasswordController = TextEditingController(); // Cán bộ Đoàn MK
  final TextEditingController _adminUserController = TextEditingController(); // Admin TK
  final TextEditingController _adminPasswordController = TextEditingController(); // Admin MK

  // Trạng thái UI
  bool _obscureOfficerPassword = true;
  bool _obscureAdminPassword = true;
  // Tách trạng thái "Lưu mật khẩu" cho từng vai trò (Cán bộ Đoàn và Admin)
  bool _rememberMeOfficer = false; 
  bool _rememberMeAdmin = false; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _studentIdController.dispose();
    _officerUserController.dispose();
    _officerPasswordController.dispose();
    _adminUserController.dispose();
    _adminPasswordController.dispose();
    super.dispose();
  }

  // Xử lý logic đăng nhập (Mô phỏng)
  void _handleLogin() {
    final currentTabIndex = _tabController.index;
    final role = _tabs[currentTabIndex];
    
    // Khởi tạo giá trị mặc định cho 'message' để tránh lỗi Non-nullable
    String message = "Lỗi hệ thống: Không xác định được vai trò đăng nhập.";
    bool success = false;

    if (currentTabIndex == 0) { // Đoàn viên
      final studentId = _studentIdController.text.trim();
      // Logic kiểm tra đăng nhập Đoàn viên
      if (studentId.isNotEmpty) { 
        success = true;
        // --- ĐIỀU HƯỚNG SANG HOMESCREEN CHO ĐOÀN VIÊN ---
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        return; 
      } else {
        message = "$role: Vui lòng nhập Mã sinh viên.";
      }
    } else if (currentTabIndex == 1) { // Cán bộ Đoàn
      final user = _officerUserController.text.trim();
      final password = _officerPasswordController.text.trim();
      // Logic kiểm tra đăng nhập Cán bộ Đoàn
      // SỬA TÊN CLASS CHUYỂN HƯỚNG: CanBoDoanHomeScreen
      if (user.isNotEmpty && password.isNotEmpty) { 
        success = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CanBoDoanHomeScreen()),
        );
        return; 
      } else {
        message = "$role: Vui lòng nhập Tài khoản và Mật khẩu.";
      }
    } else if (currentTabIndex == 2) { // Admin
      final adminUser = _adminUserController.text.trim();
      final adminPassword = _adminPasswordController.text.trim();
      // Logic kiểm tra đăng nhập Admin
      // SỬA TÊN CLASS CHUYỂN HƯỚNG: AdminHomeScreen
      if (adminUser.isNotEmpty && adminPassword.isNotEmpty) { 
        success = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
        );
        return; 
      } else {
        message = "$role: Vui lòng nhập Tài khoản và Mật khẩu Admin.";
      }
    }

    // Hiển thị thông báo (SnackBar) chỉ khi đăng nhập THẤT BẠI
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? _primaryBlue : _primaryRed,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // --- Các hàm build Form (Có cập nhật trạng thái Checkbox) ---
  
  Widget _buildDoanVienForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "* Mã sinh viên",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _primaryRed),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _studentIdController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Nhập mã sinh viên của bạn",
            border: _outlineInputBorder,
            focusedBorder: _focusedBlueOutlineInputBorder,
            prefixIcon: Icon(Icons.badge_outlined, color: _primaryBlue),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Đoàn viên chỉ cần nhập mã sinh viên để đăng nhập",
                  style: TextStyle(color: _primaryBlue, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryBlue,
              shape: const RoundedRectangleBorder(
                borderRadius: _inputBorderRadius,
              ),
              elevation: 5,
            ),
            onPressed: _handleLogin,
            child: const Text(
              "ĐĂNG NHẬP",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCanBoDoanForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "* Tài khoản",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _primaryRed),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _officerUserController,
          decoration: const InputDecoration(
            hintText: "Mã sinh viên hoặc mã giảng viên",
            border: _outlineInputBorder,
            focusedBorder: _focusedBlueOutlineInputBorder,
            prefixIcon: Icon(Icons.person_outline, color: _primaryBlue),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "* Mật khẩu",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _primaryRed),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _officerPasswordController,
          obscureText: _obscureOfficerPassword,
          decoration: InputDecoration(
            hintText: "Nhập mật khẩu",
            border: _outlineInputBorder,
            focusedBorder: _focusedBlueOutlineInputBorder,
            prefixIcon: const Icon(Icons.lock_outline, color: _primaryBlue),
            suffixIcon: IconButton(
              icon: Icon(_obscureOfficerPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: _inputHintColor),
              onPressed: () {
                setState(() {
                  _obscureOfficerPassword = !_obscureOfficerPassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _rememberMeOfficer = !_rememberMeOfficer; // SỬ DỤNG _rememberMeOfficer
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _rememberMeOfficer, // SỬ DỤNG _rememberMeOfficer
                    onChanged: (val) {
                      setState(() {
                        _rememberMeOfficer = val!; // SỬ DỤNG _rememberMeOfficer
                      });
                    },
                    activeColor: _primaryBlue,
                  ),
                  const Text("Lưu mật khẩu", style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Chuyển đến màn hình quên mật khẩu cho Cán bộ Đoàn");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Chức năng Quên mật khẩu chưa được triển khai."),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
                "Quên mật khẩu?",
                style: TextStyle(color: _primaryRed, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryBlue,
              shape: const RoundedRectangleBorder(
                borderRadius: _inputBorderRadius,
              ),
              elevation: 5,
            ),
            onPressed: _handleLogin,
            child: const Text(
              "ĐĂNG NHẬP",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdminForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "* Tài khoản Admin",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _primaryRed),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _adminUserController,
          decoration: const InputDecoration(
            hintText: "Nhập tài khoản admin",
            border: _outlineInputBorder,
            focusedBorder: _focusedRedOutlineInputBorder,
            prefixIcon: Icon(Icons.person_outline, color: _primaryRed),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "* Mật khẩu Admin",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _primaryRed),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _adminPasswordController,
          obscureText: _obscureAdminPassword,
          decoration: InputDecoration(
            hintText: "Nhập mật khẩu admin",
            border: _outlineInputBorder,
            focusedBorder: _focusedRedOutlineInputBorder,
            prefixIcon: const Icon(Icons.lock_outline, color: _primaryRed),
            suffixIcon: IconButton(
              icon: Icon(_obscureAdminPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: _inputHintColor),
              onPressed: () {
                setState(() {
                  _obscureAdminPassword = !_obscureAdminPassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _rememberMeAdmin = !_rememberMeAdmin; // SỬ DỤNG _rememberMeAdmin
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _rememberMeAdmin, // SỬ DỤNG _rememberMeAdmin
                    onChanged: (val) {
                      setState(() {
                        _rememberMeAdmin = val!; // SỬ DỤNG _rememberMeAdmin
                      });
                    },
                    activeColor: _primaryRed,
                  ),
                  const Text("Lưu mật khẩu", style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Chuyển đến màn hình quên mật khẩu cho Admin");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Chức năng Quên mật khẩu chưa được triển khai."),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
                "Quên mật khẩu?",
                style: TextStyle(color: _primaryRed, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryRed,
              shape: const RoundedRectangleBorder(
                borderRadius: _inputBorderRadius,
              ),
              elevation: 5,
            ),
            onPressed: _handleLogin,
            child: const Text(
              "ĐĂNG NHẬP ADMIN",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 Gradient nền
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [_primaryBlue, _primaryRed],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- Logo và Tiêu đề ---
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      // Sử dụng placeholder cho Image.asset
                      child: Image.asset(
                        'assets/images/logo1.jpg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Quản lý công tác đoàn",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Khoa CNTT trường Đại học Đại Nam",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- Tab Controller và Forms ---
                  Column(
                    children: [
                      // Tab Bar (Bộ chọn vai trò)
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _primaryBlue,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: _inputHintColor,
                          tabs: _tabs.map((name) => Tab(text: name)).toList(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Tab Content (Form Đăng nhập tương ứng)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          // Chiều cao cố định này phù hợp với nội dung hiện tại
                          height: 350, 
                          child: TabBarView(
                            controller: _tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildDoanVienForm(context),
                              _buildCanBoDoanForm(context),
                              _buildAdminForm(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Footer
                  const Text(
                    "© 2025 Khoa Công nghệ Thông tin - Đoàn TNCS Hồ Chí Minh",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}