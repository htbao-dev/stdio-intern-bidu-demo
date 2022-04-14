import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/modules/home/widget/group_content.dart';
import 'package:bidu_demo/modules/home/widget/item.dart';
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
      child: StreamBuilder<List<Product>>(
        stream: Provider.of<HomeBloc>(context).topProductStream,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          final List<Product> listProduct = snapshot.data ?? [];

          return SizedBox(
            height: 245,
            child: MyListView(
              itemCount: listProduct.length,
              itemBuilder: (context, index) {
                return TopProductItem(
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
