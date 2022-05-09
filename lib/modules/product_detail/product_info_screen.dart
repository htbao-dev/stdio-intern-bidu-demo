import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/common_widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String descriptionText = 'Mô tả sản phẩm';

class ProductInfoScreen extends StatelessWidget {
  final ProductDetail productDetail;
  const ProductInfoScreen({Key? key, required this.productDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().loadSuggestion();
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              imgMiniBannerAsset,
              fit: BoxFit.fitWidth,
            ),
          ),
          _productDescription(context),
          const _Suggestion(),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _productDescription(BuildContext context) {
    if (productDetail.description != null) {
      return Column(
        children: [
          const Text(
            descriptionText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            productDetail.description!,
            style: Theme.of(context).textTheme.bodyText2!,
          ),
        ],
      );
    }
    return const SizedBox();
  }
}

class _Suggestion extends StatelessWidget {
  const _Suggestion({Key? key}) : super(key: key);
  final int numberItemInRow = 3;
  @override
  Widget build(BuildContext context) {
    double itemSize =
        (MediaQuery.of(context).size.width - kVerticalPadding * 2) /
            numberItemInRow;
    return StreamBuilder<List<Product>>(
        stream: Provider.of<ProductDetailBloc>(context).suggestProductStream,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          final List<Product> listProduct = snapshot.data ?? [];
          return Wrap(
            spacing: kHorizontalPadding,
            runSpacing: kHorizontalPadding,
            children: List.generate(listProduct.length, (index) {
              return SizedBox(
                  width: itemSize,
                  child: SuggestProductItem(
                    product: listProduct[index],
                    itemSize: itemSize,
                  ));
            }),
          );
        });
  }
}
