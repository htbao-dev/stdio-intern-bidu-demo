import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/modules/product_detail/widget/divider.dart';
import 'package:flutter/material.dart';

const String basicInformationProductText = 'Thông tin sản phẩm cơ bản';

class BasicInformationProduct extends StatefulWidget {
  const BasicInformationProduct({Key? key, required this.body})
      : super(key: key);

  final String? body;
  @override
  State<BasicInformationProduct> createState() =>
      _BasicInformationProductState();
}

class _BasicInformationProductState extends State<BasicInformationProduct> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    if (widget.body == null) {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: 16),
        child: Column(
          children: const [Text(basicInformationProductText)],
        ),
      );
    }
  }
}
