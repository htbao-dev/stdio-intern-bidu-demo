import 'package:flutter/material.dart';

const String _kProductInfoText = 'Thông tin sản phẩm';
const String _kReviewText = 'Đánh giá (40)';
const String _kChatText = 'Trò chuyện';

class SecondAppbar extends StatefulWidget {
  const SecondAppbar({Key? key}) : super(key: key);

  @override
  State<SecondAppbar> createState() => _SecondAppbarState();
}

class _SecondAppbarState extends State<SecondAppbar> {
  final int _infoIndex = 0;
  final int _reviewIndex = 1;
  final int _chatIndex = 2;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.red,
      collapsedHeight: 20,
      toolbarHeight: 20,
      expandedHeight: 20,
      flexibleSpace: TabBar(
        indicatorColor: const Color(0xff1A1A1A),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        labelStyle: const TextStyle(
          color: Color(0xffC9C9C9),
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(
            child: Text(
              _kProductInfoText,
              textAlign: TextAlign.center,
              style: _currentIndex == _infoIndex
                  ? const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff1A1A1A))
                  : null,
            ),
          ),
          Tab(
            child: Text(
              _kReviewText,
              style: _currentIndex == _reviewIndex
                  ? const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff1A1A1A))
                  : null,
            ),
          ),
          Tab(
            child: Text(
              _kChatText,
              style: _currentIndex == _chatIndex
                  ? const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff1A1A1A))
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
