import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/shop.dart';

class ProductDetail extends Product {
  List<TimePrepareOrder>? timePrepareOrder;
  String? description;
  ProductDetail({
    String? id,
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
    int? salePrice,
    this.timePrepareOrder,
    this.description,
  }) : super(
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
          salePrice: salePrice,
        );

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
          shop: Shop.fromMap(
            json["shop"],
          ),
          description: json['description'],
          salePrice: json["sale_price"],
          beforeSalePrice: json["before_sale_price"],
          timePrepareOrder: json["time_prepare_order"] == null
              ? null
              : List<TimePrepareOrder>.from(json["time_prepare_order"]
                  .map((x) => TimePrepareOrder.fromMap(x))),
        );
}

class ShippingMethod {
  ShippingMethod({
    required this.id,
    required this.shippingMethodId,
    required this.name,
    required this.isActive,
    required this.token,
    required this.pickAddress,
    required this.nameQuery,
    required this.code,
  });

  String id;
  String shippingMethodId;
  String name;
  bool isActive;
  String token;
  dynamic pickAddress;
  String nameQuery;
  String code;

  ShippingMethod.fromMap(Map<String, dynamic> json)
      : this(
          id: json["_id"],
          shippingMethodId: json["shipping_method_id"],
          name: json["name"],
          isActive: json["is_active"],
          token: json["token"],
          pickAddress: json["pick_address"],
          nameQuery: json["name_query"],
          code: json["code"],
        );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "shipping_method_id": shippingMethodId,
        "name": name,
        "is_active": isActive,
        "token": token,
        "pick_address": pickAddress,
        "name_query": nameQuery,
        "code": code,
      };
}

class TimePrepareOrder {
  TimePrepareOrderDay day;
  double value;
  String unit;

  TimePrepareOrder({
    required this.day,
    required this.value,
    required this.unit,
  });

  factory TimePrepareOrder.fromMap(Map<String, dynamic> json) {
    TimePrepareOrderDay day;
    switch (json['day']) {
      case '1':
        day = TimePrepareOrderDay.oneDay;
        break;
      case '2':
        day = TimePrepareOrderDay.twoDay;
        break;
      case '3':
        day = TimePrepareOrderDay.threeDay;
        break;
      case '4':
        day = TimePrepareOrderDay.fourDay;
        break;
      default:
        day = TimePrepareOrderDay.greaterThanFourDay;
    }
    return TimePrepareOrder(
      day: day,
      value: json["value"].toDouble(),
      unit: json["unit"],
    );
  }
}

enum TimePrepareOrderDay {
  oneDay,
  twoDay,
  threeDay,
  fourDay,
  greaterThanFourDay
}
