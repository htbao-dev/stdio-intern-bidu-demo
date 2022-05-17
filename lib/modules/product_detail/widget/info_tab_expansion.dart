import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';

const headerPadding = 16.0;
const TextStyle expansionTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kPrimaryBlackColor,
    height: 20 / 14);

class ExpansionDivider extends StatelessWidget {
  const ExpansionDivider({Key? key, this.indent, this.endIndent})
      : super(key: key);
  final double? indent;
  final double? endIndent;
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      height: 1,
      color: kPrimaryGreyColor,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

class InfoTabExpansion extends StatefulWidget {
  const InfoTabExpansion({Key? key, required this.body, required this.title})
      : super(key: key);

  final Widget body;
  final String title;
  @override
  State<InfoTabExpansion> createState() => _InfoTabExpansionState();
}

class _InfoTabExpansionState extends State<InfoTabExpansion> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const ExpansionDivider(),
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: headerPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: expansionTextStyle.copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                  if (isExpanded)
                    const Icon(
                      Icons.keyboard_arrow_up,
                      color: kPrimaryPinkColor,
                    ),
                  if (!isExpanded)
                    const Icon(Icons.keyboard_arrow_down,
                        color: kPrimaryPinkColor),
                ],
              ),
            ),
          ),
          if (isExpanded) widget.body,
        ],
      ),
    );
  }
}
