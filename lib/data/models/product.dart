import 'dart:convert';

List<Product> listProductFromMap(List<dynamic> json) {
  return json.map((e) => Product.fromMap(e)).toList();
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.images,
    required this.isGuaranteedItem,
    required this.isGenuineItem,
    required this.isBookmarked,
    this.beforeSalePrice,
    this.salePrice,
    required this.createdAt,
    required this.sold,
    required this.quantity,
    required this.shopId,
    required this.discountPercent,
    required this.priceMinMax,
    required this.shop,
  });

  String id;
  String name;
  List<String> images;
  bool isGuaranteedItem;
  bool isGenuineItem;
  bool isBookmarked;
  int? beforeSalePrice;
  int? salePrice;
  DateTime createdAt;
  int sold;
  int quantity;
  String shopId;
  int discountPercent;
  PriceMinMax priceMinMax;
  Shop shop;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        isGuaranteedItem: json["is_guaranteed_item"],
        isGenuineItem: json["is_genuine_item"],
        isBookmarked: json["is_bookmarked"],
        beforeSalePrice: json["before_sale_price"],
        salePrice: json["sale_price"],
        createdAt: DateTime.parse(json["createdAt"]),
        sold: json["sold"],
        quantity: json["quantity"],
        shopId: json["shop_id"],
        discountPercent: json["discount_percent"],
        priceMinMax: PriceMinMax.fromMap(json["price_min_max"]),
        shop: Shop.fromMap(json["shop"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x)),
        "is_guaranteed_item": isGuaranteedItem,
        "is_genuine_item": isGenuineItem,
        "is_bookmarked": isBookmarked,
        "before_sale_price": beforeSalePrice,
        "sale_price": salePrice,
        "createdAt": createdAt.toIso8601String(),
        "sold": sold,
        "quantity": quantity,
        "shop_id": shopId,
        "discount_percent": discountPercent,
        "price_min_max": priceMinMax.toMap(),
        "shop": shop.toMap(),
      };
}

class PriceMinMax {
  PriceMinMax({
    this.min,
    this.max,
  });

  int? min;
  int? max;

  factory PriceMinMax.fromJson(String str) =>
      PriceMinMax.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceMinMax.fromMap(Map<String, dynamic> json) => PriceMinMax(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toMap() => {
        "min": min,
        "max": max,
      };
}

class Shop {
  Shop({
    required this.id,
    required String country,
  }) {
    _country = country;
  }

  String id;
  String? _country;

  String get country {
    switch (_country) {
      case "VN":
        return "Việt Nam";
      case "KO":
        return "Hàn Quốc";
      default:
        return "";
    }
  }

  factory Shop.fromJson(String str) => Shop.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Shop.fromMap(Map<String, dynamic> json) => Shop(
        id: json["_id"],
        country: json["country"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "country": country,
      };
}
