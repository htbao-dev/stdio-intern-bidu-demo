import 'package:bidu_demo/common/formatter.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class ListItem extends StatelessWidget {
  const ListItem({Key? key}) : super(key: key);

  factory ListItem.forNewestProduct({required Product product}) {
    return _NewestProductItem(product: product);
  }
  factory ListItem.forTopProduct({required Product product, int? index}) {
    return _TopProductItem(
      product: product,
      index: index,
    );
  }
  factory ListItem.forTopSearch({required Keyword keyword}) {
    return _TopSearchItem(keyword: keyword);
  }

  Widget productImage(String src) {
    return Container(
      height: 120,
      width: 120,
      padding: const EdgeInsets.only(bottom: 5),
      child: Image.network(
        src, fit: BoxFit.cover,
        // height: ,
      ),
    );
  }

  Widget productName(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        name,
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

  Widget productLocation(String country) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 10,
          color: Color(0xffC9C9C9),
        ),
        Text(
          country,
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }

  Widget imageWithBookmark(String src) {
    return Stack(
      children: [
        productImage(src),
        const Positioned(child: _BookMart(), top: 7, right: 7)
      ],
    );
  }

  Widget productTag(
      {required bool isGuaranteedItem, required bool isGenuineItem}) {
    final Widget child;
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

class _BookMart extends StatefulWidget {
  const _BookMart({Key? key}) : super(key: key);

  @override
  State<_BookMart> createState() => __BookMartState();
}

class __BookMartState extends State<_BookMart> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/icon_bookmark.svg',
    );
  }
}

class _NewestProductItem extends ListItem {
  final Product product;
  const _NewestProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageWithBookmark(product.images[0]),
          productTag(
              isGenuineItem: product.isGenuineItem,
              isGuaranteedItem: product.isGuaranteedItem),
          productName(product.name),
          productPrice(product.salePrice),
          productLocation(product.shop.country)
        ],
      ),
    );
  }
}

class _TopProductItem extends ListItem {
  final Product product;
  final int? index;
  const _TopProductItem({Key? key, required this.product, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              imageWithBookmark(product.images[0]),
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
          productLocation(product.shop.country),
          productSold(product.sold),
        ],
      ),
    );
  }

  Widget productSold(int sold) {
    return Text(
      'Đã bán $sold',
      style: const TextStyle(
        fontSize: 10,
        color: Color(0xffC9C9C9),
      ),
    );
  }
}

class _TopSearchItem extends ListItem {
  final Keyword keyword;

  const _TopSearchItem({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8.0),
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
  Widget productName(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
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

class _TopSellerItem extends ListItem{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}