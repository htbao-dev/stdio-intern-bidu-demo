import 'package:bidu_demo/common/formatter.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/modules/common_widget/bookmark.dart';
import 'package:bidu_demo/modules/product_detail/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';

abstract class ListItem extends StatelessWidget {
  const ListItem({Key? key}) : super(key: key);

  Widget productImage(String src, {double? width, double? height}) {
    double _width = width ?? 120;
    double _height = height ?? 120;
    return Container(
      height: _height,
      width: _width,
      padding: const EdgeInsets.only(bottom: 5),
      child: Image.network(
        src, fit: BoxFit.cover,
        // height: ,
      ),
    );
  }

  Widget productName(String? name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        name ?? '',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        softWrap: true,
        maxLines: 2,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget productPrice(int? salePrice) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        Formatter.currency(salePrice),
        // '${product.salePrice} đ',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget productLocation(String? country) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 10,
          color: Color(0xffC9C9C9),
        ),
        Text(
          country ?? '',
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }

  Widget imageWithBookmark(String? src, {double? width, double? height}) {
    return src != null
        ? Stack(
            children: [
              productImage(src, width: width, height: height),
              const Positioned(child: BookMark(), top: 7, right: 7)
            ],
          )
        : const SizedBox();
  }

  Widget productTag(
      {required bool? isGuaranteedItem, required bool? isGenuineItem}) {
    final Widget child;
    isGenuineItem ??= false;
    isGuaranteedItem ??= false;
    if (!isGuaranteedItem && !isGenuineItem) {
      child = const SizedBox();
    } else {
      final String txt;
      if (isGuaranteedItem) {
        txt = 'Đảm bảo';
      } else {
        txt = 'Chính hãng';
      }
      const color = Color(0xffFD37AE);
      child = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
        ),
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 10,
            color: color,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: child,
    );
  }

  Widget productSold(int? sold) {
    sold ??= 0;
    return Text(
      'Đã bán $sold',
      style: const TextStyle(
        fontSize: 10,
        color: Color(0xffC9C9C9),
      ),
    );
  }
}

class _Rank extends StatelessWidget {
  final int index;
  const _Rank({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text('${index + 1}',
          style: const TextStyle(fontSize: 14, color: Colors.white)),
    );
  }
}

class NewestProductItem extends ListItem {
  final Product product;
  const NewestProductItem({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageWithBookmark(product.images?[0]),
            productTag(
                isGenuineItem: product.isGenuineItem,
                isGuaranteedItem: product.isGuaranteedItem),
            productName(product.name),
            productPrice(product.salePrice),
            productLocation(product.shop?.country)
          ],
        ),
      ),
    );
  }
}

class TopSearchItem extends ListItem {
  final Keyword keyword;

  const TopSearchItem({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          productImage(keyword.avatar),
          productName(keyword.keyword),
          totalProduct(keyword.totalProduct),
        ],
      ),
    );
  }

  @override
  Widget productName(String? name) {
    return Text(
      name ?? '',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget totalProduct(int totalProduct) {
    return Text(
      '$totalProduct sản phẩm',
      style: const TextStyle(
        fontSize: 12,
      ),
    );
  }
}

class TopProductItem extends ListItem {
  final Product product;
  final int? index;
  const TopProductItem({Key? key, required this.product, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                imageWithBookmark(product.images?[0]),
                if (index != null && index! < 5)
                  Positioned(
                    child: _Rank(index: index!),
                    top: 7,
                    left: 7,
                  ),
              ],
            ),
            productTag(
                isGenuineItem: product.isGenuineItem,
                isGuaranteedItem: product.isGuaranteedItem),
            productName(product.name),
            productPrice(product.salePrice),
            productLocation(product.shop?.country),
            productSold(product.sold),
          ],
        ),
      ),
    );
  }
}

class SuggestProductItem extends ListItem {
  final Product product;
  const SuggestProductItem({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var width = (screenSize.width - 30) / 2;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              imageWithBookmark(product.images?[0],
                  height: width, width: width),
            ],
          ),
          productTag(
              isGenuineItem: product.isGenuineItem,
              isGuaranteedItem: product.isGuaranteedItem),
          productName(product.name),
          productPrice(product.salePrice),
          productLocation(product.shop?.country),
          productSold(product.sold),
          productLocation(product.shop?.country),
        ],
      ),
    );
  }
}

// class _TopSellerItem extends ListItem {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
