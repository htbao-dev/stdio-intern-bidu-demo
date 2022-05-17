import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/modules/common_widget/item.dart';
import 'package:bidu_demo/modules/product_detail/widget/divider.dart';
import 'package:bidu_demo/modules/product_detail/widget/see_all_button.dart';
import 'package:flutter/material.dart';

class InfoTabListProduct extends StatelessWidget {
  const InfoTabListProduct(
      {Key? key, required this.listProduct, required this.title})
      : super(key: key);
  final String title;
  final int numberItemInRow = 3;
  final double itemPadding = 6;
  final List<Product>? listProduct;
  @override
  Widget build(BuildContext context) {
    double itemSize =
        (MediaQuery.of(context).size.width - kHorizontalPadding * 2) /
                numberItemInRow -
            itemPadding;
    if (listProduct != null) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding, vertical: kVerticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 20),
                Wrap(
                  spacing: itemPadding,
                  runSpacing: kHorizontalPadding,
                  children: List.generate(listProduct!.length, (index) {
                    return SizedBox(
                        width: itemSize,
                        child: ProductItem2(
                          product: listProduct![index],
                          imageSize: itemSize,
                        ));
                  }),
                ),
                const SizedBox(height: 20),
                const SeeAllButton(),
              ],
            ),
          ),
          const BoldDivider(),
        ],
      );
    } else {
      return Container();
    }
  }
}
