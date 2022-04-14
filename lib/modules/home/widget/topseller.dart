import 'package:bidu_demo/modules/home/widget/group_content.dart';
import 'package:flutter/material.dart';

class HomeTopSeller extends StatelessWidget {
  const HomeTopSeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeGroupContent(
      title: 'Top Người Bán', seeMore: () {}, child: Container(),
      // BlocBuilder<HomeBloc, HomeState>(
      //   buildWhen: (previous, current) => current is NewestProductLoaded,
      //   builder: (context, state) {
      //     if (state is NewestProductLoaded) {
      //       final listProduct = state.listProduct;
      //       return Container();
      //     }
      //     return Container();
      //   },
      // ),
    );
  }
}
