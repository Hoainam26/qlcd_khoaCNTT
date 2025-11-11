import 'package:flutter/material.dart';

// Định nghĩa các hằng số màu sắc và văn bản mới (Tông Xanh Dương)
const Color primaryBlue = Color(0xFF3F51B5); // Màu Xanh Dương (Indigo)
const Color primaryDarkBlue = Color(0xFF303F9F); // Màu Xanh Dương đậm hơn cho Sidebar
const Color _sidebarTextColor = Color(0xFFF9F9F9); // Màu sáng cho chữ trong sidebar
const Color _activeBgColor = Color(0xFFC5CAE9); // Màu nền active nhẹ nhàng
const Color _activeFgColor = Color(0xFF1A237E); // Màu chữ active

// --- Dữ liệu Menu ---
class MenuItem {
  final String title;
  final IconData icon;
  final String path;

  MenuItem({required this.title, required this.icon, required this.path});
}

class MenuGroup {
  final String title;
  final List<MenuItem> items;
  
  MenuGroup({required this.title, required this.items});
}

final List<MenuGroup> menuData = [
  MenuGroup(
    title: 'QUẢN TRỊ VIÊN',
    items: [
      MenuItem(title: 'Dashboard', icon: Icons.dashboard, path: '/dashboard'),
      MenuItem(title: 'Tổng quan', icon: Icons.bar_chart, path: '/overview'),
      MenuItem(title: 'Thống kê', icon: Icons.pie_chart, path: '/statistics'),
      MenuItem(title: 'Báo cáo', icon: Icons.file_copy, path: '/reports'),
      MenuItem(title: 'Điều ước', icon: Icons.star_border, path: '/wish'),
    ],
  ),
  MenuGroup(
    title: 'DANH MỤC CHUNG',
    items: [
      MenuItem(title: 'Khóa', icon: Icons.school, path: '/khoa'),
      MenuItem(title: 'Chi đoàn', icon: Icons.group, path: '/chidoan'),
    ],
  ),
  MenuGroup(
    title: 'QUẢN LÝ NGƯỜI DÙNG',
    items: [
      MenuItem(title: 'Tài khoản & Vai trò', icon: Icons.security, path: '/roles'),
    ],
  ),
  MenuGroup(
    title: 'CÀI ĐẶT',
    items: [
      MenuItem(title: 'Chung', icon: Icons.settings, path: '/settings/general'),
      MenuItem(title: 'Hệ thống', icon: Icons.computer, path: '/settings/system'),
      MenuItem(title: 'Bảo mật', icon: Icons.lock, path: '/settings/security'),
      MenuItem(title: 'Thông báo', icon: Icons.notifications, path: '/settings/notifications'),
    ],
  ),
];

// --- Màn hình chính ---
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  // State quản lý mục đang được chọn
  String _currentTitle = 'Dashboard'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Màu nền xám nhạt
      appBar: AppBar(
        title: const Text(
          'Hệ Thống QL Đoàn Viên',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryBlue, // Dùng màu xanh dương
        foregroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          // Nút Tìm kiếm (Chỉ hiện thị trên mobile)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Xử lý tìm kiếm
            },
          ),
          // Icon người dùng
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'A', // Admin User
                style: TextStyle(color: primaryBlue, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      
      // Menu Sidebar (Sử dụng Drawer cho mobile)
      drawer: _SidebarMenu(
        currentTitle: _currentTitle,
        onItemSelected: (title) {
          setState(() {
            _currentTitle = title;
            // Đóng drawer sau khi chọn
            Navigator.pop(context); 
          });
        },
      ),

      // Nội dung chính
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thanh Tìm kiếm và Tiêu đề (Chỉ hiện thị trên desktop/tablet)
            _SearchAndProfileBar(currentTitle: _currentTitle),
            
            const SizedBox(height: 20),
            
            // Nội dung Dashboard hoặc các chức năng khác
            _ContentArea(title: _currentTitle),
          ],
        ),
      ),
    );
  }
}

// --- Widget Thanh Tìm kiếm và Thông tin Admin (Desktop/Tablet) ---
class _SearchAndProfileBar extends StatelessWidget {
  final String currentTitle;
  const _SearchAndProfileBar({required this.currentTitle});

  @override
  Widget build(BuildContext context) {
    // Ẩn thanh này trên mobile để ưu tiên AppBar
    if (MediaQuery.of(context).size.width < 600) {
      return Container();
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currentTitle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm... (Ctrl+K)',
                  hintStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
                  suffixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: const Center(
                      child: Text('Ctrl+K', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ),

        Row(
          children: [
            const Icon(Icons.notifications_none, color: Colors.grey),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Admin User', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text('Quản trị viên', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: primaryBlue, // Dùng màu xanh dương
              child: const Text('AU', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }
}

// --- Widget Menu Sidebar ---
class _SidebarMenu extends StatelessWidget {
  final String currentTitle;
  final Function(String) onItemSelected;

  const _SidebarMenu({required this.currentTitle, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Container(
        color: primaryDarkBlue, // Dùng màu xanh dương đậm hơn
        child: Column(
          children: [
            // Header
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1))
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quản trị viên',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hệ thống quản lý đoàn viên',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: menuData.length,
                itemBuilder: (context, groupIndex) {
                  final group = menuData[groupIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tiêu đề nhóm
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 12, bottom: 4),
                        child: Text(
                          group.title,
                          style: TextStyle(
                            color: _sidebarTextColor.withOpacity(0.6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      // Các mục menu trong nhóm
                      ...group.items.map((item) {
                        final isSelected = item.title == currentTitle;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                          child: Material(
                            // Màu nền active sáng hơn màu sidebar
                            color: isSelected ? primaryBlue : Colors.transparent, 
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: () => onItemSelected(item.title),
                              borderRadius: BorderRadius.circular(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Icon(item.icon, size: 20, color: isSelected ? Colors.white : _sidebarTextColor),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : _sidebarTextColor,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widget Nội dung Chính (Dashboard/Placeholder) ---
class _ContentArea extends StatelessWidget {
  final String title;

  const _ContentArea({required this.title});

  @override
  Widget build(BuildContext context) {
    if (title != 'Dashboard') {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Nội dung cho "$title" sẽ được tải ở đây.', 
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
    
    // Nội dung Dashboard
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thẻ thống kê
        GridView.count(
          shrinkWrap: true,
          // 2 cột trên mobile, 4 cột trên màn hình rộng
          crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _StatCard(
              title: 'Tổng Đoàn viên',
              value: '2,500',
              icon: Icons.people_outline,
              color: primaryBlue, // Dùng màu xanh dương
            ),
            _StatCard(
              title: 'Chi đoàn HĐ',
              value: '45',
              icon: Icons.groups_2_outlined,
              color: Colors.green,
            ),
            _StatCard(
              title: 'Số lượng Khóa',
              value: '12',
              icon: Icons.school_outlined,
              color: Colors.orange,
            ),
            _StatCard(
              title: 'Báo cáo cần duyệt',
              value: '8',
              icon: Icons.notifications_active_outlined,
              color: Colors.red,
            ),
          ],
        ),
        
        const SizedBox(height: 20),

        // Ví dụ Bảng dữ liệu
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Danh sách Đoàn viên mới',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              // Bảng cần cuộn ngang trên mobile
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24,
                  dataRowMinHeight: 40,
                  dataRowMaxHeight: 40,
                  headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)),
                  columns: const [
                    DataColumn(label: Text('Mã SV', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    DataColumn(label: Text('Họ Tên', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    DataColumn(label: Text('Chi đoàn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    DataColumn(label: Text('Trạng thái', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('20IT001', style: TextStyle(fontSize: 13))),
                      DataCell(Text('Nguyễn Văn A', style: TextStyle(fontSize: 13))),
                      DataCell(Text('IT2001', style: TextStyle(fontSize: 13))),
                      DataCell(_StatusChip(text: 'Đã kích hoạt', color: Colors.green)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('21IT005', style: TextStyle(fontSize: 13))),
                      DataCell(Text('Trần Thị B', style: TextStyle(fontSize: 13))),
                      DataCell(Text('IT2102', style: TextStyle(fontSize: 13))),
                      DataCell(_StatusChip(text: 'Chờ duyệt', color: Colors.orange)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Widget Thẻ Thống kê (Stat Card) ---
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Viền bên trái sử dụng màu đã chọn
        border: Border(left: BorderSide(color: color, width: 5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(icon, color: color.withOpacity(0.6), size: 24),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Widget Trạng thái (Chip) ---
class _StatusChip extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}