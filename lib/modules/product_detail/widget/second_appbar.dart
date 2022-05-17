import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:flutter/material.dart';

const String _kReviewText = 'Đánh giá (40)';

class SecondAppbar extends StatefulWidget {
  final TabController controller;
  const SecondAppbar({Key? key, required this.controller}) : super(key: key);

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
      toolbarHeight: 0,
      expandedHeight: 0,
      collapsedHeight: 0,
      flexibleSpace: TabBar(
        indicatorColor: kPrimaryBlackColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        labelStyle: const TextStyle(
          color: kPrimaryGreyColor,
          fontWeight: FontWeight.w400,
        ),
        controller: widget.controller,
        tabs: [
          Tab(
            child: Text(Strings.productInfo,
                textAlign: TextAlign.center, style: _tabStyle(_infoIndex)),
          ),
          Tab(
            child: Text(
              _kReviewText,
              style: _tabStyle(_reviewIndex),
            ),
          ),
          Tab(
            child: Text(Strings.chat, style: _tabStyle(_chatIndex)),
          ),
        ],
      ),
    );
  }

  TextStyle _tabStyle(int itemIndex) {
    return _currentIndex == itemIndex
        ? const TextStyle(
            fontWeight: FontWeight.bold, color: kPrimaryBlackColor)
        : const TextStyle(
            fontWeight: FontWeight.w400,
            color: kPrimaryGreyColor,
            fontSize: 14);
  }
}
