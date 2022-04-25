import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/product_detail/widget/appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/bottom_appbar.dart';
import 'package:bidu_demo/modules/product_detail/widget/delivery_info.dart';
import 'package:bidu_demo/modules/product_detail/widget/group_content.dart';
import 'package:bidu_demo/modules/product_detail/widget/product_price.dart';
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
                      const GroupContent(
                        child: ShopName(),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        borderType: BorderType.thin,
                      ),
                      const GroupContent(
                        child: ProductPrice(),
                        borderType: BorderType.thin,
                      ),
                      // const GroupContent(child: Evaluation()),
                      const GroupContent(child: DeliveryInfo()),
                    ],
                  ),
                ),
              ],
            );
          }),
      bottomNavigationBar: const BottmAppBar(),
    );
  }
}
