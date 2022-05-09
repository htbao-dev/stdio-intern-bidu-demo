import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/product_detail/product_info_screen.dart';
import 'package:bidu_demo/modules/product_detail/widget/appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/bottom_appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/delivery_info.dart';
import 'package:bidu_demo/modules/product_detail/widget/evaluation.dart';
import 'package:bidu_demo/modules/product_detail/widget/product_price.dart';
import 'package:bidu_demo/modules/product_detail/widget/second_appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/shop_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-details-screen';
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().initLoad(widget.product);
    return Scaffold(
      body: StreamBuilder<ProductDetail>(
          stream: context.read<ProductDetailBloc>().productDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
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
                  SecondAppbar(
                    controller: controller,
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        ProductInfoScreen(productDetail: snapshot.data!),
                        const Text("Tab 2"), //demo
                        const Text("Tab 3"),
                      ],
                    ),
                  )
                ],
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
