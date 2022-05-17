import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription(this.description, {Key? key}) : super(key: key);
  final String? description;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  // bool isCollapse = true;
  @override
  Widget build(BuildContext context) {
    if (widget.description != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          // clipBehavior: isCollapse ? Clip.hardEdge : Clip.none,
          children: [
            Text(
              Strings.descriptionText,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
            ),
            Text(
              widget.description!,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
            ),
            Text(
              widget.description!,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
            ),
            Text(
              widget.description!,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
            ),
            Text(
              widget.description!,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
            ),
            Text(
              widget.description!,
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

class ProductDescriptionWithSeemore extends StatefulWidget {
  const ProductDescriptionWithSeemore({Key? key, this.description})
      : super(key: key);
  final String? description;

  @override
  State<ProductDescriptionWithSeemore> createState() =>
      _ProductDescriptionWithSeemoreState();
}

class _ProductDescriptionWithSeemoreState
    extends State<ProductDescriptionWithSeemore> {
  bool isCollapse = true;
  final _key = GlobalKey();
  // late final Size size;

  @override
  Widget build(BuildContext context) {
    // Widget description = ProductDescription(widget.description, key: _key);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: isCollapse ? 400 : null,
          child: Wrap(
            clipBehavior: Clip.hardEdge,
            children: [
              ProductDescription(
                widget.description,
                key: _key,
              ),
            ],
          ),
        ),
        isCollapse
            ? Container(
                height: 93,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isCollapse = false;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(
                        color: kPrimaryBlackColor,
                        height: 1,
                        thickness: 1,
                        endIndent: kHorizontalPadding,
                        indent: kHorizontalPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Strings.seemore,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: kPrimaryPinkColor,
                          ),
                          const SizedBox(height: 10)
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
