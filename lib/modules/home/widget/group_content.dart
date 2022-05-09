import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String _kSeeAllText = 'Xem tất cả';

class HomeGroupContent extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? seeMore;
  final EdgeInsets? padding;

  const HomeGroupContent({
    Key? key,
    required this.title,
    required this.child,
    this.seeMore,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: kVerticalPadding),
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
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
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
                        Text(_kSeeAllText,
                            style: Theme.of(context).textTheme.bodyText2!),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: kHalfHorizontalPadding),
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
            padding: const EdgeInsets.only(top: 20),
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
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: kHalfHorizontalPadding,
      ),
    );
  }
}
