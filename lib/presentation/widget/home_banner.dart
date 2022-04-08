import 'package:bidu_demo/data/models/banner.dart' as model;
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is BannerAndCategoryLoaded) {
        final listBanner = state.listBanner;
        return CarouselSlider(
          items: [for (final banner in listBanner) itemBuilder(banner)],
          options: CarouselOptions(
            aspectRatio: 16 / 7.6,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7),
            autoPlayAnimationDuration: const Duration(milliseconds: 300),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            scrollDirection: Axis.horizontal,
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget itemBuilder(model.SystemBanner banner) {
    return Image.network(banner.images!.first.middle!);
  }
}
