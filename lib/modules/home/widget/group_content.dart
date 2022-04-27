import 'package:bidu_demo/common/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String _kSeeAllText = 'Xem tất cả';

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
      padding: const EdgeInsets.symmetric(vertical: 10),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (seeMore != null)
                  GestureDetector(
                    onTap: seeMore,
                    child: Row(
                      children: [
                        const Text(
                          _kSeeAllText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            // color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SvgPicture.asset(
                            iconSeemoreAsset,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: child,
          ),
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
      child: ListView.builder(
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal),
    );
  }
}
