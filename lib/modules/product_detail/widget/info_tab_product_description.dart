import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDescriptionWithSeemore extends StatefulWidget {
  const ProductDescriptionWithSeemore({Key? key, this.description, this.images})
      : super(key: key);
  final String? description;
  final List<String>? images;

  @override
  State<ProductDescriptionWithSeemore> createState() =>
      _ProductDescriptionWithSeemoreState();
}

class _ProductDescriptionWithSeemoreState
    extends State<ProductDescriptionWithSeemore>
    with AutomaticKeepAliveClientMixin {
  bool isCollapse = false;
  final double _heightCollapse = 400;
  final _key = GlobalKey();

  @override
  void initState() {
    //wait for column render
    final instance = WidgetsBinding.instance!;
    instance.addPostFrameCallback((_) {
      final widgetHeight = _getDescriptionHeight();
      if (widgetHeight > _heightCollapse) {
        setState(() {
          isCollapse = true;
        });
      }
    });
    super.initState();
  }

  double _getDescriptionHeight() {
    return _key.currentContext!.size!.height;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: isCollapse ? _heightCollapse : null,
          child: Wrap(
            clipBehavior: Clip.hardEdge,
            children: [
              _ProductDescription(
                description: widget.description,
                images: widget.images,
                key: _key,
              ),
            ],
          ),
        ),
        isCollapse
            ? Container(
                height: 93, //height of see more button
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

  @override
  bool get wantKeepAlive => true;
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({Key? key, this.description, this.images})
      : super(key: key);

  final String? description;
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        // clipBehavior: isCollapse ? Clip.hardEdge : Clip.none,
        children: [
          if (description != null)
            Column(
              children: [
                Text(
                  Strings.descriptionText,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 16),
                ),
                Text(
                  description!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
          if (images != null) CachedNetworkImage(imageUrl: images![0]),
        ],
      ),
    );
  }
}
