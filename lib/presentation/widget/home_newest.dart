import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:bidu_demo/presentation/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNewest extends StatelessWidget {
  const HomeNewest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeGroupContent(
      title: 'Sản Phẩm Mới Nhất',
      seeMore: () {
        // ignore: avoid_print
        print('see more');
      },
      child: SizedBox(
          height: 230,
          child: StreamBuilder<HomeState>(
              stream: Provider.of<HomeBloc>(context).newestProductStream,
              builder:
                  (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
                final List<Product> listItem;
                if (snapshot.data is NewestProductLoaded) {
                  listItem = (snapshot.data as NewestProductLoaded).listProduct;
                } else {
                  listItem = [];
                }

                return MyListView(
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    return ListItem.forNewestProduct(
                      product: listItem[index],
                    );
                  },
                );
              })
          // BlocBuilder<HomeBloc, HomeState>(
          //   buildWhen: (previous, current) => current is NewestProductLoaded,
          //   builder: (context, state) {
          //     if (state is NewestProductLoaded) {
          //       return MyListView(
          //         itemCount: state.listProduct.length,
          //         itemBuilder: (context, index) {
          //           return ListItem.forNewestProduct(
          //             product: state.listProduct[index],
          //           );
          //         },
          //       );
          //     }
          //     return Container();
          //   },
          // ),
          ),
    );
  }
}
