import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookMark extends StatefulWidget {
  const BookMark({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  State<BookMark> createState() => __BookMartState();
}

class __BookMartState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/icon_bookmark.svg',
      color: widget.color,
    );
  }
}
