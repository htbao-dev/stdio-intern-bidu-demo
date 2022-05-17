import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/common_widget/item.dart';
import 'package:bidu_demo/modules/product_detail/widget/info_tab_expansion.dart';
import 'package:bidu_demo/modules/product_detail/widget/divider.dart';
import 'package:bidu_demo/modules/product_detail/widget/info_tab_product_description.dart';
import 'package:bidu_demo/modules/product_detail/widget/see_all_button.dart';
import 'package:bidu_demo/modules/product_detail/widget/info_tab_list_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String suggestionText = 'Gợi Ý Cho Bạn';
const String similarProductText = 'Sản phẩm tương tự';
const String basicInformationProductText = 'Thông tin sản phẩm cơ bản';
const String kLaundryInstructionsText = 'Hướng dẫn giặt ủi';
const data = {
  'Thương hiệu': 'Hàn Quốc',
  'Chất liệu': 'cotton 100%',
  'Hướng dẫn giao hàng':
      'Cửa hàng sẽ đóng gói sản phẩm kỹ càng dựa theo hướng dẫn của BIDU. Mỗi đơn hàng đều có hóa đơn đính kèm gói hàng khi nhận được từ đơn vị vận chuyển. Quay lại video khi nhận và mở hàng phòng trường hợp xảy ra khiếu nại với đơn vị vận chuyển.'
};

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
          ProductDescriptionWithSeemore(description: productDetail.description),
          const SizedBox(height: 30),
          InfoTabExpansion(
            title: basicInformationProductText,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 5,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${e.key}: ',
                          style: expansionTextStyle.copyWith(
                              fontWeight: FontWeight.w600)),
                      Text(
                        e.value,
                        style: expansionTextStyle,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const InfoTabExpansion(
              title: kLaundryInstructionsText, body: SizedBox()),
          const ExpansionDivider(
            indent: kHorizontalPadding,
            endIndent: kHorizontalPadding,
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
