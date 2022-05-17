import 'package:flutter/material.dart';

class ThinDivider extends StatelessWidget {
  final double? height;
  const ThinDivider({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color(0xffF1F1F1),
      thickness: 1,
      height: height,
    );
  }
}

class BoldDivider extends StatelessWidget {
  final double? height;
  const BoldDivider({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 4,
      height: height,
      color: const Color(0xffF6F7F7),
    );
  }
}
