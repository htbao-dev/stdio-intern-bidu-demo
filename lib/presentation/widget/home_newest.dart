import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:bidu_demo/presentation/widget/home_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNewest extends StatelessWidget {
  const HomeNewest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeGroupContent(
      title: 'Sản Phẩm Mới Nhất',
      // seeMore: () {
      //   print('see more');
      // },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is NewestProductLoaded,
        builder: (context, state) {
          if (state is NewestProductLoaded) {
            final listProduct = state.listProduct;
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}
