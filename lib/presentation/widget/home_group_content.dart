import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/presentation/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeGroupContent extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? seeMore;
  const HomeGroupContent({
    Key? key,
    required this.title,
    required this.child,
    this.seeMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (seeMore != null)
                GestureDetector(
                  onTap: seeMore,
                  child: Row(
                    children: [
                      const Text(
                        'Xem tất cả',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          // color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: SvgPicture.asset(
                          'assets/icons/icon_seemore.svg',
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
          child,
        ],
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  const MyListView(
      {Key? key, required this.itemBuilder, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal),
    );
  }
}
