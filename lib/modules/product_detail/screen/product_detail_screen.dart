import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/product_detail/widget/appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/product_title.dart';
import 'package:bidu_demo/modules/product_detail/widget/shop_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details-screen';
  final String productId;
  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().initLoad(productId);
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: context.read<ProductDetailBloc>().isDataNullStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return const Center(
                child: Text('No data'),
              );
            }
            return CustomScrollView(
              slivers: [
                const ProductDetailAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: const ShopName(),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffF1F1F1)))),
                      ),
                      Container(
                        child: const ProductTitle(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
