import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/common_widget/item.dart';
import 'package:bidu_demo/modules/product_detail/widget/basic_infomation_product.dart';
import 'package:bidu_demo/modules/product_detail/widget/divider.dart';
import 'package:bidu_demo/modules/product_detail/widget/info_tab_product_description.dart';
import 'package:bidu_demo/modules/product_detail/widget/see_all_button.dart';
import 'package:bidu_demo/modules/product_detail/widget/info_tab_list_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String suggestionText = 'Gợi Ý Cho Bạn';
const String similarProductText = 'Sản phẩm tương tự';

class ProductInfoTab extends StatelessWidget {
  final ProductDetail productDetail;
  // final ScrollPhysics physics;
  const ProductInfoTab({
    Key? key,
    required this.productDetail,
    // required this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().loadSuggestion();
    context.read<ProductDetailBloc>().loadSimilarProduct();
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20, bottom: kVerticalPadding),
            child: Image.asset(
              imgMiniBannerAsset,
              fit: BoxFit.fitWidth,
            ),
          ),
          ProductDescription(productDetail.description),
          const BasicInformationProduct(
            body: 'aaaaaaaaaaaaaaaaaaaaaaaaaa',
          ),
          StreamBuilder<List<Product>>(
              stream: context.read<ProductDetailBloc>().similarProductStream,
              builder: (context, snapshot) {
                final listProduct = snapshot.data;
                return InfoTabListProduct(
                    title: similarProductText, listProduct: listProduct);
              }),
          StreamBuilder<List<Product>>(
              stream: context.read<ProductDetailBloc>().suggestProductStream,
              builder: (context, snapshot) {
                final listProduct = snapshot.data;
                return InfoTabListProduct(
                  title: suggestionText,
                  listProduct: listProduct,
                );
              }),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
