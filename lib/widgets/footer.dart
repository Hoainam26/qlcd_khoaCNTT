import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/doan_screen.dart';

class Footer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Footer({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  void _handleNavigation(BuildContext context, int index) {
    // Cập nhật giao diện hiện tại
    onItemTapped(index);

    // Điều hướng theo tab
    switch (index) {
      case 1: // Công tác đoàn
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DoanScreen()),
        );
        break;
      case 4: // Cá nhân
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      default:
        // Tab khác không cần điều hướng
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => _handleNavigation(context, index),
      backgroundColor: Colors.white,
      height: 70,
      elevation: 3,
      indicatorColor: Colors.blueAccent.withOpacity(0.15),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded, color: Colors.blueAccent),
          label: 'Trang chủ',
        ),
        NavigationDestination(
          icon: Icon(Icons.workspace_premium_outlined),
          selectedIcon:
              Icon(Icons.workspace_premium, color: Colors.blueAccent),
          label: 'Công tác đoàn',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          selectedIcon:
              Icon(Icons.chat_bubble_rounded, color: Colors.blueAccent),
          label: 'Tin nhắn',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded, color: Colors.blueAccent),
          label: 'Khám phá',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded, color: Colors.blueAccent),
          label: 'Cá nhân',
        ),
      ],
    );
  }
}
