import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailAppBar extends StatefulWidget {
  final ProductDetail productDetail;
  const ProductDetailAppBar(this.productDetail, {Key? key}) : super(key: key);

  @override
  State<ProductDetailAppBar> createState() => _ProductDetailAppBarState();
}

class _ProductDetailAppBarState extends State<ProductDetailAppBar> {
  late List<String> images;
  @override
  void initState() {
    super.initState();

    images = widget.productDetail.images ?? [];
  }

  @override
  Widget build(BuildContext context) {
    double expandedHeight = MediaQuery.of(context).size.width - kToolbarHeight;
    return SliverAppBar(
        pinned: true,
        snap: false,
        floating: false,
        expandedHeight: expandedHeight,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: kHalfHorizontalPadding),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: kHalfHorizontalPadding),
            child: CircleAvatar(
              child: SvgPicture.asset(iconShareAsset),
              backgroundColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: kHalfHorizontalPadding),
            child: CircleAvatar(
                child: SvgPicture.asset(
                  iconCartAsset,
                ),
                backgroundColor: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(right: kHalfHorizontalPadding),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        flexibleSpace: _CarouselAppbar(
          images: images,
        ));
  }
}

class _CarouselAppbar extends StatefulWidget {
  final List<String> images;
  const _CarouselAppbar({Key? key, required this.images}) : super(key: key);

  @override
  State<_CarouselAppbar> createState() => _CarouselAppbarState();
}

class _CarouselAppbarState extends State<_CarouselAppbar> {
  int _indicatorIndex = 0;
  late final bool isMultiImage;

  @override
  void initState() {
    super.initState();
    isMultiImage = widget.images.length != 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: CarouselSlider.builder(
            itemCount: widget.images.length,
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: double.infinity,
              enlargeCenterPage: true,
              autoPlay: isMultiImage,
              enableInfiniteScroll: isMultiImage,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _indicatorIndex = index;
                });
              },
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            itemBuilder: (context, index, _) {
              return widget.images.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.images[index],
                      fit: BoxFit.cover,
                    )
                  : const SizedBox();
            },
          ),
        ),
        Positioned.fill(
          child: Align(
              child: _indicator(context, widget.images),
              alignment: Alignment.bottomCenter),
          bottom: 18,
        ),
        Positioned(
          child: SvgPicture.asset(iconFullScreenAsset),
          bottom: kHorizontalPadding,
          right: kVerticalPadding,
        ),
      ],
    );
  }

  Widget _indicator(BuildContext context, List<String> images) {
    if (images.isEmpty || images.length == 1) return const SizedBox();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images.asMap().entries.map((entry) {
        return Container(
          width: 25.0,
          height: 3.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: _indicatorIndex == entry.key
                  ? Colors.white
                  : Colors.grey[300]),
        );
      }).toList(),
    );
  }
}
