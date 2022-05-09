import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';

const String descriptionText = 'Mô tả sản phẩm';

class ProductDescription extends StatelessWidget {
  const ProductDescription(this.description, {Key? key}) : super(key: key);
  final String? description;
  @override
  Widget build(BuildContext context) {
    if (description != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            Text(
              descriptionText,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
            ),
            Text(
              description!,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
