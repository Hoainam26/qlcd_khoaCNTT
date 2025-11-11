import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/news.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  int _currentBanner = 0;

  final List<Map<String, dynamic>> tabs = [
    {"label": "Tin tức", "icon": Icons.newspaper_rounded, "color": Colors.blue},
    {"label": "Thi đua", "icon": Icons.military_tech_rounded, "color": Colors.orange},
    {"label": "Tài liệu", "icon": Icons.folder_open_rounded, "color": Colors.teal},
    {"label": "Kiến nghị", "icon": Icons.forum_rounded, "color": Colors.purple},
    {"label": "Phúc lợi", "icon": Icons.volunteer_activism_rounded, "color": Colors.green},
  ];

  final List<String> bannerImages = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  final List<News> allNews = [
    News(
      title: "Hơn 70% sinh viên CNTT DNU có việc làm ngay khi chưa tốt nghiệp",
      subtitle: "Sinh viên CNTT DNU nhận việc làm trước khi tốt nghiệp với mức lương khởi điểm hấp dẫn.",
      date: "22/07/2025",
      imageUrl: "https://atm273446-s3user.vcos.cloudstorage.com.vn/dhdainam/thumbnail/images/posts/61687/image-thumb__61687__optimizeSizeThumbnail/z6826268959104_2408caa07415bfdeaee72933f0db8935_1753156356.d618592e.jpg",
      content: "CNTT là một trong những khoa lớn của Đại học Đại Nam hiện đang đào tạo các ngành: CNTT, Khoa học máy tính, Hệ thống thông tin. Hơn 70% sinh viên có việc làm ngay sau tốt nghiệp với mức lương khởi điểm từ 12 – 21 triệu đồng/tháng. Nhiều bạn được tuyển dụng từ khi còn ngồi trên ghế giảng đường. …",
    ),
    News(
      title: "Sinh viên CNTT DNU nhận học bổng toàn phần du học tại Đài Loan",
      subtitle: "Cơ hội học bổng toàn phần cho sinh viên CNTT Đại Nam học tập tại Đài Loan.",
      date: "18/10/2024",
      imageUrl: "https://atm273446-s3user.vcos.cloudstorage.com.vn/dhdainam/asset/asset/fixed/jd4eo4cfvhohvmhwafh920240328023845_thump.jpg",
      content: "Sinh viên ngành Công nghệ thông tin DNU sẽ học tập trực tiếp tại Đại học Đài Cương (Đài Loan). Chương trình hợp tác quốc tế này nhằm mở rộng tầm nhìn và cơ hội nghề nghiệp cho sinh viên. Học bổng bao gồm miễn học phí và hỗ trợ sinh hoạt phí. …",
    ),
    News(
      title: "Khoa CNTT Đại Nam đang đào tạo những ngành nào?",
      subtitle: "Giới thiệu các ngành đào tạo tại Khoa Công nghệ thông tin Đại học Đại Nam.",
      date: "17/06/2024",
      imageUrl: "https://img.lsvn.vn/uploads/photos/1013/00000003/6260c8c497a0a.jpg",
      content: "Khoa CNTT Đại học Đại Nam đang đào tạo 3 ngành gồm: Công nghệ thông tin, Khoa học máy tính, Hệ thống thông tin. Với nền tảng mỗi ngành có cách đào tạo khác nhau về thời gian và môn chuyên sâu. …",
    ),
    News(
      title: "Khoa CNTT Trường Đại học Đại Nam tưng bừng kỷ niệm 10 năm thành lập",
      subtitle: "Lễ kỷ niệm 10 năm và gặp mặt sinh viên, giảng viên của Khoa CNTT",
      date: "28/09/2019",
      imageUrl: "https://atm273446-s3user.vcos.cloudstorage.com.vn/dhdainam/asset/asset/fixed/cntt-10nam-thanh-lap.jpg",
      content: "(Dân trí) — Sáng 28/9, Khoa CNTT Trường ĐH Đại Nam tổ chức kỷ niệm 10 năm thành lập. Buổi lễ có sự tham dự của Ban Giám hiệu, các thầy cô, sinh viên và cựu sinh viên. Phát biểu tại sự kiện, lãnh đạo nhấn mạnh hành trình phát triển và khẳng định uy tín của khoa. …",
    ),
    News(
      title: "Lời khuyên hữu ích cho người theo đuổi ngành CNTT",
      subtitle: "Những gợi ý để định hướng ngành CNTT cho học sinh và sinh viên",
      date: "15/01/2016",
      imageUrl: "https://atm273446-s3user.vcos.cloudstorage.com.vn/dhdainam/asset/asset/fixed/88hpuo01m4le830r6lqr20220401040200_thump.jpg",
      content: "Khoa CNTT Đại học Đại Nam chia sẻ lời khuyên cho sinh viên như: chọn đúng trường, học ngoại ngữ, kỹ năng mềm, cập nhật công nghệ mới. …",
    ),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== BANNER SLIDER ======
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() => _currentBanner = index);
                    },
                  ),
                  items: bannerImages.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    );
                  }).toList(),
                ),

                // ====== CHẤM INDICATOR ======
                Positioned(
                  bottom: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: bannerImages.asMap().entries.map((entry) {
                      return Container(
                        width: _currentBanner == entry.key ? 10 : 8,
                        height: _currentBanner == entry.key ? 10 : 8,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentBanner == entry.key
                              ? Colors.white
                              : Colors.white54,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            // ====== SLOGAN ======
            Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: const EdgeInsets.all(12),
              child: const Text(
                'SINH VIÊN ĐẠI NAM - KIẾN TẠO TƯƠNG LAI',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            // ====== TABS DANH MỤC (vuốt ngang + icon đẹp) ======
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  final tab = tabs[index];
                  final bool isSelected = _currentTab == index;

                  return GestureDetector(
                    onTap: () => setState(() => _currentTab = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      width: 90,
                      decoration: BoxDecoration(
                        color: isSelected ? tab['color'] : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: tab['color'].withOpacity(0.4),
                                  blurRadius: 6,
                                  offset: const Offset(2, 3),
                                )
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            tab['icon'],
                            size: 30,
                            color: isSelected ? Colors.white : tab['color'],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            tab['label'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ====== DANH SÁCH TIN TỨC ======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: allNews.map((news) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(news: news),
                        ),
                      );
                    },
                    child: NewsCard(news: news),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      // ====== NÚT THÊM MỚI ======
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 28),
      ),

      // ====== THANH ĐIỀU HƯỚNG DƯỚI ======
      bottomNavigationBar: Footer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
