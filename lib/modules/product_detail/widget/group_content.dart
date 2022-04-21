import 'package:flutter/material.dart';

class GroupContent extends StatelessWidget {
  final Widget child;
  final BorderType borderType;
  final EdgeInsetsGeometry padding;
  const GroupContent(
      {Key? key,
      required this.child,
      this.borderType = BorderType.bold,
      this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 16)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: padding,
      decoration: BoxDecoration(
        border: _border(borderType),
      ),
    );
  }

  Border _border(BorderType type) {
    switch (type) {
      case BorderType.bold:
        return const Border(
          bottom: BorderSide(
            color: Color(0xffF6F7F7),
            width: 4,
          ),
        );
      case BorderType.thin:
        return const Border(
          bottom: BorderSide(color: Color(0xffF1F1F1)),
        );
    }
  }
}

enum BorderType { thin, bold }
