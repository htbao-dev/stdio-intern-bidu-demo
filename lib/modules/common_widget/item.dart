import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/formatter.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/shop.dart';
import 'package:bidu_demo/modules/common_widget/bookmark.dart';
import 'package:bidu_demo/modules/product_detail/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String _kGuaranteedText = 'Đảm bảo';
const String _kGenuineText = 'Chính hãng';
const String _kSoldText = 'Đã bán';
const String _kFlollowText = 'lượt theo dõi';
const String _kSeeShopText = 'Xem shop';

const double _kItemWidth = 150;

abstract class ListItem extends StatelessWidget {
  const ListItem({Key? key}) : super(key: key);
  Widget productImage(String src, {double? width, double? height}) {
    double _width = width ?? _kItemWidth;
    double _height = height ?? 150;
    return SizedBox(
      height: _height,
      width: _width,
      child: CachedNetworkImage(
        imageUrl: src, fit: BoxFit.cover,
        // height: ,
      ),
    );
  }

  Widget productName(BuildContext context, String? name) {
    return Text(
      name ?? '',
      style: Theme.of(context).textTheme.bodyText2,
      softWrap: true,
      maxLines: 2,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget productPrice(int? salePrice) {
    return Text(
      Formatter.currency(salePrice),
      // '${product.salePrice} đ',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget productLocation(String? country) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 10,
          color: kPrimaryGreyColor,
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
        txt = _kGuaranteedText;
      } else {
        txt = _kGenuineText;
      }
      child = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryPinkColor, width: 1),
        ),
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 10,
            color: kPrimaryPinkColor,
          ),
        ),
      );
    }
    return child;
  }

  Widget productSold(int? sold) {
    sold ??= 0;
    return Text(
      '$_kSoldText $sold',
      style: const TextStyle(
        fontSize: 10,
        color: kPrimaryGreyColor,
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
        color: kPrimaryBlackColor,
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
      child: SizedBox(
        width: _kItemWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            imageWithBookmark(product.images?[0]),
            const SizedBox(height: 5),
            productTag(
                isGenuineItem: product.isGenuineItem,
                isGuaranteedItem: product.isGuaranteedItem),
            const SizedBox(height: 5),
            productName(context, product.name),
            const SizedBox(height: 5),
            productPrice(product.salePrice),
            const SizedBox(height: 4),
            productLocation(product.shop?.country)
          ],
        ),
      ),
    );
  }
}

class TopSearchItem extends ListItem {
  final Keyword keyword;
  final String kProductText = 'sản phẩm';
  final double topSearchItemWidth = 150;
  const TopSearchItem({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: topSearchItemWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          productImage(keyword.avatar,
              height: topSearchItemWidth, width: topSearchItemWidth),
          const SizedBox(height: 6),
          productName(context, keyword.keyword),
          const SizedBox(height: 4),
          totalProduct(context, keyword.totalProduct),
        ],
      ),
    );
  }

  @override
  Widget productName(BuildContext context, String? name) {
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

  Widget totalProduct(BuildContext context, int totalProduct) {
    return Text('$totalProduct $kProductText',
        style: Theme.of(context).textTheme.bodyText2!);
  }
}

class TopProductItem extends ListItem {
  final Product product;
  final int? index;
  final double topProductItemWidth = 150;
  const TopProductItem({Key? key, required this.product, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product);
      },
      child: SizedBox(
        width: topProductItemWidth,
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
            const SizedBox(height: 5),
            productTag(
                isGenuineItem: product.isGenuineItem,
                isGuaranteedItem: product.isGuaranteedItem),
            const SizedBox(height: 5),
            productName(context, product.name),
            const SizedBox(height: 5),
            productPrice(product.salePrice),
            const SizedBox(height: 4),
            productLocation(product.shop?.country),
            const SizedBox(height: 4),
            productSold(product.sold),
          ],
        ),
      ),
    );
  }
}

class SuggestProductItem extends ListItem {
  final Product product;
  final double itemSize;
  const SuggestProductItem(
      {Key? key, required this.product, required this.itemSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  height: itemSize, width: itemSize),
            ],
          ),
          const SizedBox(height: 5),
          productTag(
              isGenuineItem: product.isGenuineItem,
              isGuaranteedItem: product.isGuaranteedItem),
          const SizedBox(height: 5),
          productName(context, product.name),
          const SizedBox(height: 5),
          productPrice(product.salePrice),
          const SizedBox(height: 5),
          productSold(product.sold),
          const SizedBox(height: 5),
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
      style: Theme.of(context).textTheme.bodyText2!,
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
                      child: SvgPicture.asset(iconAddAsset),
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
                        iconHeartAsset,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.69),
                        child: Text(shop.avgRating.toString()),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        color: kPrimaryBlackColor,
                        width: 1,
                        height: 11,
                      ),
                      Text(
                        shop.user!.followCount.toString() + ' $_kFlollowText',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(_kSeeShopText),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SvgPicture.asset(
                          iconSeemoreAsset,
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
      path = iconNo1Asset;
    } else if (rank == 2) {
      path = iconNo2Asset;
    } else {
      path = iconNo3Asset;
    }
    return SvgPicture.asset(
      path,
    );
  }

  Widget _rankChange(int oldRank, int newRank) {
    const Color redColor = Color(0xffFF3232);
    const Color greenColor = Color(0xff12B74A);
    final int change = newRank - oldRank;
    if (change > 0) {
      return Row(
        children: [
          const Icon(
            Icons.arrow_drop_up,
            color: greenColor,
          ),
          Text(
            change.abs().toString(),
            style: const TextStyle(
              color: greenColor,
            ),
          ),
        ],
      );
    } else if (change < 0) {
      return Row(
        children: [
          const Icon(Icons.arrow_drop_down, color: redColor),
          Text(
            change.abs().toString(),
            style: const TextStyle(color: redColor),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
