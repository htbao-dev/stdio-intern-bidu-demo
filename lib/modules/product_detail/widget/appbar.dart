import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailAppBar extends StatefulWidget {
  const ProductDetailAppBar({Key? key}) : super(key: key);

  @override
  State<ProductDetailAppBar> createState() => _ProductDetailAppBarState();
}

class _ProductDetailAppBarState extends State<ProductDetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 370.0,
      flexibleSpace: FlexibleSpaceBar(
        background: StreamBuilder<ProductDetail>(
            stream: context.read<ProductDetailBloc>().productDetailStream,
            builder: (context, snapshot) {
              List<String> images = snapshot.data?.images ?? [];
              return CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  // aspectRatio: 1.0,
                  viewportFraction: 1.0,
                  height: double.infinity,

                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                itemBuilder: (context, index, _) {
                  return images.isNotEmpty
                      ? Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        )
                      : const SizedBox();
                },
              );
            }),
      ),
    );
  }
}
