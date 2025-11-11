import 'package:flutter/material.dart';

class Member {
  final String role;
  final String name;
  final String image;

  const Member({required this.role, required this.name, required this.image});
}

class DoanScreen extends StatelessWidget {
  const DoanScreen({super.key});

  static const List<Member> members = [
    Member(role: 'Bí thư', name: 'Lê Văn Phong', image: 'assets/images/bt_lvp.JPG'),
    Member(role: 'Phó bí thư', name: 'Lê Tuấn Anh', image: 'assets/images/pbt_lta.JPG'),
    Member(role: 'Phó bí thư', name: 'Nguyễn Thái Khánh', image: 'assets/images/pbt_ntk.JPG'),
    Member(role: 'Phó bí thư', name: 'Trần Thị Thanh Nhàn', image: 'assets/images/pbt_tttn.JPG'),
    Member(role: 'Ủy viên', name: 'Nguyễn Thị Phương', image: 'assets/images/dv3.jpg'),
    Member(role: 'Ủy viên', name: 'Lê Thị Vân Anh', image: 'assets/images/dv1.jpg'),
    Member(role: 'Ủy viên', name: 'Nguyễn Thị Kim Hoa', image: 'assets/images/dv2.jpg'),
  ];

  static List<List<Member>> get tiers => [
        [members[0]], // Bí thư
        members.sublist(1, 4), // Phó bí thư
        members.sublist(4), // Ủy viên
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Công tác đoàn'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          // ==== Nội dung thành viên ====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  ...tiers.map((tier) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: tier.map((m) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.blue.shade600, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.shade200.withOpacity(0.4),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      m.image,
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  m.role,
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  m.name,
                                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20), // padding trước footer
                ],
              ),
            ),
          ),

          // ==== Footer cố định xuống dưới ====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: const [
                Text(
                  'Đoàn Khoa CNTT - Đại học Đại Nam',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  'Thanh niên Việt Nam - Năng động, Sáng tạo, Tiên phong!',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Email: fit@dnu.edu.vn | SĐT: 0987 654 321',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
