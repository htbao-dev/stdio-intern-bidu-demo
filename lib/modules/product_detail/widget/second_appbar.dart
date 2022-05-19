import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:flutter/material.dart';

const String _kReviewText = 'Đánh giá';

class SecondAppbar extends StatefulWidget {
  const SecondAppbar(
      {Key? key, required this.controller, required this.feedbacks})
      : super(key: key);

  final TabController controller;
  final Feedbacks feedbacks;
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
    return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverHeaderDelegate(
          child: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              color: Colors.white,
              child: TabBar(
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
                        textAlign: TextAlign.center,
                        style: _tabStyle(_infoIndex)),
                  ),
                  Tab(
                    child: Text(
                      '$_kReviewText ${widget.feedbacks.totalByComment ?? 0}',
                      style: _tabStyle(_reviewIndex),
                    ),
                  ),
                  Tab(
                    child: Text(Strings.chat, style: _tabStyle(_chatIndex)),
                  ),
                ],
              ),
            ),
          ),
        ));
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

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverHeaderDelegate({
    required this.child,
  });

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
}
