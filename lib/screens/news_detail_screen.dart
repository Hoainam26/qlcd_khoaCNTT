import 'package:flutter/material.dart';
import '../models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({super.key, required this.news});

  // Hàm giả định khi nhấn nút Share
  void _shareNews(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đang chia sẻ tin tức...')),
    );
    // Thực tế sẽ dùng share_plus package ở đây
  }

  // Hàm giả định khi nhấn nút Bookmark
  void _toggleBookmark(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu tin tức!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          // 1. SliverAppBar - Ảnh Nổi Bật & Các Icon Tương tác (Action Icons)
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            
            // THÊM ICON TƯƠNG TÁC (ACTIONS) Ở ĐÂY
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () => _shareNews(context),
                tooltip: 'Chia sẻ',
              ),
              IconButton(
                // Biểu tượng bookmark (đã lưu)
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () => _toggleBookmark(context),
                tooltip: 'Lưu tin tức',
              ),
              const SizedBox(width: 8), // Khoảng cách bên phải
            ],
            
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: false,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: news.imageUrl,
                    child: Image.network(
                      news.imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. SliverList - Nội dung chi tiết
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TIÊU ĐỀ
                      Text(
                        news.title,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                      
                      const SizedBox(height: 12),

                      // THÔNG TIN META (CÓ ICON)
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            news.date,
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('|', style: TextStyle(color: Colors.grey)),
                          ),
                          const Icon(Icons.person_outline, size: 16, color: Colors.grey), // Icon Tác giả
                          const SizedBox(width: 4),
                          Text(
                            'Admin',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 40, thickness: 0.5, color: Colors.grey),

                      // NỘI DUNG
                      Text(
                        news.content,
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      const SizedBox(height: 30),

                      // THÊM VÙNG TƯƠNG TÁC CUỐI BÀI VIẾT (ACTION BAR)
                      _buildBottomActionBar(context),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Widget riêng biệt cho Action Bar ở cuối bài viết
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            context,
            icon: Icons.thumb_up_alt_outlined,
            text: 'Thích',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã thích!'))),
          ),
          _buildActionButton(
            context,
            icon: Icons.comment_outlined,
            text: 'Bình luận',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chuyển tới khu vực bình luận'))),
          ),
          _buildActionButton(
            context,
            icon: Icons.share_outlined,
            text: 'Chia sẻ',
            onTap: () => _shareNews(context),
          ),
        ],
      ),
    );
  }

  // Widget nhỏ cho từng nút trong Action Bar
  Widget _buildActionButton(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, size: 24, color: Colors.blue.shade600),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.blue.shade600, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}