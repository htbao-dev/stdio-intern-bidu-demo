import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final CarouselController _controller = CarouselController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeState>(
      stream: Provider.of<HomeBloc>(context).bannerAndCategoryStream,
      builder: (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
        final List<SystemBanner> listBanner;
        if (snapshot.data is BannerAndCategoryLoaded) {
          listBanner = (snapshot.data as BannerAndCategoryLoaded).listBanner;
        } else {
          listBanner = [];
        }
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
                  setState(() {
                    _currentIndex = index;
                  });
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
    return Image.network(banner.images!.first.middle!);
  }

  Widget _indicator(BuildContext context, List<SystemBanner> listBanner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listBanner.asMap().entries.map((entry) {
        return Container(
          width: 25.0,
          height: 3.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color:
                  _currentIndex == entry.key ? Colors.white : Colors.grey[300]),
        );
      }).toList(),
    );
  }
}
