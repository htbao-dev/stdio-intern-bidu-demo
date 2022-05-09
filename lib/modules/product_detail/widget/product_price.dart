import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/formatter.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/modules/common_widget/bookmark.dart';
import 'package:bidu_demo/modules/common_widget/gradient_text.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String _kDiscountInputText = 'Nhập mã khuyến mãi giảm giá tối đa 200k';
const String _kRefundText = 'Đổi trả trong vòng 3 ngày';

class ProductPrice extends StatelessWidget {
  final ProductDetail productDetail;
  const ProductPrice(this.productDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = productDetail.name;
    final price = productDetail.salePrice;
    final beforePrice = productDetail.beforeSalePrice;
    final discountPercent = productDetail.discountPercent;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kVerticalPadding, horizontal: kHalfHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productName(context, name),
          _price(
              beforePrice: beforePrice,
              price: price,
              discountPercent: discountPercent),
          TextButton.icon(
            onPressed: () {
              debugPrint('Bookmark');
            },
            label: const GradientText(
              _kRefundText,
              gradient: LinearGradient(
                colors: [
                  Color(0xffFD37AE),
                  Color(0xffFD374F),
                ],
              ),
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            icon: SvgPicture.asset(iconExclamation),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.only(bottom: kVerticalPadding),
              ),
            ),
          ),
          Center(child: _discountInputButton()),
        ],
      ),
    );
  }

  Widget _productName(BuildContext context, String? name) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (name != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.8,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                ),
                maxLines: 2,
                softWrap: true,
              ),
            ),
            const Spacer(),
            const BookMark(
              color: kPrimaryBlackColor,
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _price({
    int? price,
    int? beforePrice,
    int? discountPercent,
  }) {
    if (price != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        Formatter.currency(price),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (beforePrice != null)
                      Text(
                        Formatter.currency(beforePrice),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xffC4C4C4),
                            decoration: TextDecoration.lineThrough),
                      ),
                  ],
                ),
                if (discountPercent != null)
                  Container(
                    color: const Color(0xffFD37AE),
                    margin: const EdgeInsets.only(left: 5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Text(
                      '$discountPercent%',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _discountInputButton() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xffFD374F),
          Color(0xffFD37AE),
        ],
      ).createShader(bounds),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Text(
          _kDiscountInputText,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
      ),
    );
  }
}
