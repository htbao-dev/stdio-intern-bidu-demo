import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner>
    with AutomaticKeepAliveClientMixin {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<BannerAndCategory>(
      stream: context.read<HomeBloc>().bannerAndCategoryStream,
      builder:
          (BuildContext context, AsyncSnapshot<BannerAndCategory> snapshot) {
        final List<SystemBanner> listBanner = snapshot.data?.listBanner ?? [];
        return Stack(
          children: [
            CarouselSlider(
              items: [for (final banner in listBanner) _itemBuilder(banner)],
              carouselController: _controller,
              options: CarouselOptions(
                aspectRatio: 16 / 7.5,
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 7),
                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  context.read<HomeBloc>().onBannerChanged(index);
                },
              ),
            ),
            Positioned.fill(
              child: Align(
                  child: _indicator(context, listBanner),
                  alignment: Alignment.bottomCenter),
              bottom: 18,
            )
          ],
        );
      },
    );
  }

  Widget _itemBuilder(SystemBanner banner) {
    return CachedNetworkImage(
      imageUrl: banner.images?.first.middle ?? '',
    );
  }

  Widget _indicator(BuildContext context, List<SystemBanner> listBanner) {
    return StreamBuilder<int>(
        stream: context.read<HomeBloc>().bannerIndicatorStream,
        initialData: 0,
        builder: (context, snapshot) {
          final int currentIndex = snapshot.data ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listBanner.asMap().entries.map((entry) {
              return Container(
                width: 25.0,
                height: 3.0,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: currentIndex == entry.key
                        ? Colors.white
                        : Colors.grey[300]),
              );
            }).toList(),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
