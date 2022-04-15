List<Product> listProductFromMap(List<dynamic> json) {
  return json.map((e) => Product.fromMap(e)).toList();
}

class Product {
  Product({
    this.id,
    this.name,
    this.images,
    this.isGuaranteedItem,
    this.isGenuineItem,
    this.isBookmarked,
    this.beforeSalePrice,
    this.salePrice,
    this.createdAt,
    this.sold,
    this.quantity,
    this.shopId,
    this.discountPercent,
    this.priceMinMax,
    this.shop,
  });

  String? id;
  String? name;
  List<String>? images;
  bool? isGuaranteedItem;
  bool? isGenuineItem;
  bool? isBookmarked;
  int? beforeSalePrice;
  int? salePrice;
  DateTime? createdAt;
  int? sold;
  int? quantity;
  String? shopId;
  int? discountPercent;
  PriceMinMax? priceMinMax;
  Shop? shop;

  Product.fromMap(Map<String, dynamic> json)
      : this(
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
}

class PriceMinMax {
  PriceMinMax({
    this.min,
    this.max,
  });

  int? min;
  int? max;

  PriceMinMax.fromMap(Map<String, dynamic> json)
      : this(
          min: json["min"],
          max: json["max"],
        );
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

  Shop.fromMap(Map<String, dynamic> json)
      : this(
          id: json["_id"],
          country: json["country"],
        );
}
