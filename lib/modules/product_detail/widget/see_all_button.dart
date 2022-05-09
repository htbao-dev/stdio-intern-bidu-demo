import 'dart:developer';

import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({Key? key}) : super(key: key);
  final double _verticalPadding = 12;
  final double _height = 40;
  final String seeAllText = 'Xem tất cả';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log('See all');
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: _verticalPadding),
          height: _height,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: kPrimaryBlackColor, width: 1),
          ),
          child: Text(
            seeAllText,
          )),
    );
  }
}
