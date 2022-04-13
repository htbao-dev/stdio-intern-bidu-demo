import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:bidu_demo/presentation/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTopProduct extends StatefulWidget {
  const HomeTopProduct({Key? key}) : super(key: key);

  @override
  State<HomeTopProduct> createState() => _HomeTopProductState();
}

class _HomeTopProductState extends State<HomeTopProduct>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomeGroupContent(
      title: 'Top Sản Phẩm',
      child: StreamBuilder<HomeState>(
        stream: Provider.of<HomeBloc>(context).topProductStream,
        builder: (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
          final List<Product> listProduct;
          if (snapshot.data is TopProductLoaded) {
            listProduct = (snapshot.data as TopProductLoaded).listProduct;
          } else {
            listProduct = [];
          }

          return SizedBox(
            height: 245,
            child: MyListView(
              itemCount: listProduct.length,
              itemBuilder: (context, index) {
                return ListItem.forTopProduct(
                  product: listProduct[index],
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
