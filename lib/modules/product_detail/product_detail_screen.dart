import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/product_detail/widget/appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/bottom_appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/delivery_info.dart';
import 'package:bidu_demo/modules/product_detail/widget/evaluation.dart';
import 'package:bidu_demo/modules/product_detail/widget/product_price.dart';
import 'package:bidu_demo/modules/product_detail/widget/second_appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/shop_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details-screen';
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().initLoad(product);
    return Scaffold(
      body: StreamBuilder<ProductDetail>(
          stream: context.read<ProductDetailBloc>().productDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DefaultTabController(
                length: 3,
                child: CustomScrollView(
                  slivers: [
                    ProductDetailAppBar(snapshot.data!),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ShopName(snapshot.data!),
                          _thinDivider(),
                          ProductPrice(snapshot.data!),
                          _thinDivider(),
                          const Evaluation(),
                          _boldDivider(),
                          DeliveryInfo(snapshot.data!),
                          _boldDivider(),
                        ],
                      ),
                    ),
                    const SecondAppbar(),
                    ...[],
                    const SliverFillRemaining(
                      child: TabBarView(
                        children: [
                          Text("Tab 1"), //demo
                          Text("Tab 2"),
                          Text("Tab 3"),
                        ],
                      ),
                    ) //TODO: thu xem
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }

  Widget _thinDivider() {
    return const Divider(
      color: Color(0xffF1F1F1),
      thickness: 1,
    );
  }

  Widget _boldDivider() {
    return const Divider(
      thickness: 4,
      color: Color(0xffF6F7F7),
    );
  }
}
