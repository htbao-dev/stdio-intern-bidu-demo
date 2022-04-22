import 'package:bidu_demo/common/formatter.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/shop.dart';
import 'package:bidu_demo/modules/common_widget/bookmark.dart';
import 'package:bidu_demo/modules/product_detail/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class ListItem extends StatelessWidget {
  const ListItem({Key? key}) : super(key: key);

  Widget productImage(String src, {double? width, double? height}) {
    double _width = width ?? 120;
    double _height = height ?? 120;
    return Container(
      height: _height,
      width: _width,
      padding: const EdgeInsets.only(bottom: 5),
      child: CachedNetworkImage(
        imageUrl: src, fit: BoxFit.cover,
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
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text('$index',
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
            .pushNamed(ProductDetailsScreen.routeName, arguments: product);
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            .pushNamed(ProductDetailsScreen.routeName, arguments: product);
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
                    child: _Rank(index: index! + 1),
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
            .pushNamed(ProductDetailsScreen.routeName, arguments: product);
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

class TopSellerItem extends ListItem {
  final Shop shop;
  final int rank;
  const TopSellerItem({
    Key? key,
    required this.shop,
    required this.rank,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xff1A1A1A),
      ),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Color(0xffF5F5F5), width: 2),
        )),
        padding: const EdgeInsets.only(bottom: 10, top: 20),
        child: Row(
          children: [
            _Rank(
              index: rank,
            ),
            Container(
              height: 82,
              width: 68,
              margin: const EdgeInsets.only(left: 20, right: 16),
              child: Stack(
                children: [
                  // Container(

                  // ),
                  Align(
                      child: CachedNetworkImage(
                    imageUrl: shop.user?.avatar ?? '',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xffBBBBBB).withOpacity(0.25),
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                              spreadRadius: 0),
                        ],
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
                  Positioned(child: _rankIcon(rank), top: 0, right: 9),
                  Align(
                    child: Container(
                      child: SvgPicture.asset('assets/icons/icon_add.svg'),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xffBBBBBB).withOpacity(0.25),
                              blurRadius: 5,
                              offset: const Offset(1, 1),
                              spreadRadius: 0),
                        ],
                      ),
                    ),
                    alignment: const Alignment(0, 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.user?.userName ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/icon-heart-2.svg',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.69),
                        child: Text(shop.avgRating.toString()),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        color: const Color(0xff1A1A1A),
                        width: 1,
                        height: 11,
                      ),
                      Text(
                        shop.user!.followCount.toString() + ' lượt theo dõi',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Xem shop'),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SvgPicture.asset(
                          'assets/icons/icon_seemore.svg',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            _rankChange(shop.rankingYesterday!, shop.rankingToday!),
          ],
        ),
      ),
    );
  }

  Widget _rankIcon(int rank) {
    String path;
    if (rank == 1) {
      path = 'assets/icons/icon_no1.svg';
    } else if (rank == 2) {
      path = 'assets/icons/icon_no2.svg';
    } else {
      path = 'assets/icons/icon_no3.svg';
    }
    return SvgPicture.asset(
      path,
    );
  }

  Widget _rankChange(int oldRank, int newRank) {
    int change = newRank - oldRank;
    if (change > 0) {
      return Row(
        children: [
          const Icon(
            Icons.arrow_drop_up,
            color: Color(0xff12B74A),
          ),
          Text(
            change.abs().toString(),
            style: const TextStyle(
              color: Color(0xff12B74A),
            ),
          ),
        ],
      );
    } else if (change < 0) {
      return Row(
        children: [
          const Icon(Icons.arrow_drop_down, color: Color(0xffFF3232)),
          Text(
            change.abs().toString(),
            style: const TextStyle(color: Color(0xffFF3232)),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
