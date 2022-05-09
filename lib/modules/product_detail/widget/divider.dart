import 'package:flutter/material.dart';

class ThinDivider extends StatelessWidget {
  const ThinDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(0xffF1F1F1),
      thickness: 1,
    );
  }
}

class BoldDivider extends StatelessWidget {
  const BoldDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 4,
      color: Color(0xffF6F7F7),
    );
  }
}
