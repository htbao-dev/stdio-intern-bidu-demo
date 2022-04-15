import 'package:bidu_demo/data/models/product.dart';

class ProductDetail extends Product {
  ProductDetail(
      {String? id,
      String? name,
      List<String>? images,
      bool? isGuaranteedItem,
      bool? isGenuineItem,
      bool? isBookmarked,
      DateTime? createdAt,
      int? quantity,
      String? shopId,
      int? discountPercent,
      PriceMinMax? priceMinMax,
      Shop? shop,
      int? sold,
      int? beforeSalePrice,
      int? salePrice})
      : super(
            id: id,
            name: name,
            images: images,
            isGuaranteedItem: isGuaranteedItem,
            isGenuineItem: isGenuineItem,
            isBookmarked: isBookmarked,
            createdAt: createdAt,
            sold: sold,
            quantity: quantity,
            shopId: shopId,
            discountPercent: discountPercent,
            priceMinMax: priceMinMax,
            shop: shop,
            beforeSalePrice: beforeSalePrice,
            salePrice: salePrice);

  ProductDetail.fromMap(Map<String, dynamic> json)
      : this(
          id: json["_id"],
          name: json["name"],
          images: List<String>.from(json["images"].map((x) => x)),
          isGuaranteedItem: json["is_guaranteed_item"],
          isGenuineItem: json["is_genuine_item"],
          isBookmarked: json["is_bookmarked"],
          createdAt: DateTime.parse(json["createdAt"]),
          sold: json["sold"],
          quantity: json["quantity"],
          shopId: json["shop_id"],
          discountPercent: json["discount_percent"],
          priceMinMax: PriceMinMax.fromMap(json["price_min_max"]),
          shop: Shop.fromMap(json["shop"]),
        );
}
