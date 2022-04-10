// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

List<SystemBanner> listBannerFromMap(List<dynamic> json) {
  return List<SystemBanner>.from(
      json.map((item) => SystemBanner.fromMap(item)));
}

class SystemBanner {
  SystemBanner({
    required this.id,
    required this.name,
    required this.promoLink,
    required this.isActive,
    required this.images,
    required this.products,
    required this.startTime,
    required this.shopId,
    required this.endTime,
    required this.order,
    required this.classify,
    required this.position,
    required this.vouchers,
    required this.advanceActions,
    required this.priority,
    required this.shortenLink,
    required this.description,
  });

  String id;
  String name;
  String? promoLink;
  bool isActive;
  List<ImageBanner>? images;
  List<dynamic>? products;
  dynamic startTime;
  dynamic shopId;
  dynamic endTime;
  dynamic order;
  String classify;
  String position;
  List<dynamic> vouchers;
  dynamic advanceActions;
  int priority;
  String shortenLink;
  dynamic description;

  factory SystemBanner.fromJson(String str) =>
      SystemBanner.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory SystemBanner.fromMap(Map<String, dynamic> json) => SystemBanner(
        id: json["_id"],
        name: json["name"],
        promoLink: json["promo_link"],
        isActive: json["is_active"],
        images: List<ImageBanner>.from(
            json["images"].map((x) => ImageBanner.fromMap(x))),
        products: List<dynamic>.from(json["products"].map((x) => x)),
        startTime: json["start_time"],
        shopId: json["shop_id"],
        endTime: json["end_time"],
        order: json["order"],
        classify: json["classify"],
        position: json["position"],
        vouchers: List<dynamic>.from(json["vouchers"].map((x) => x)),
        advanceActions: json["advance_actions"],
        priority: json["priority"],
        shortenLink: json["shorten_link"],
        description: json["description"],
      );

  // Map<String, dynamic> toMap() => {
  //     "_id": id,
  //     "name": name,
  //     "image": image,
  //     "promo_link": promoLink,
  //     "is_active": isActive,
  //     "images": List<dynamic>.from(images.map((x) => x.toMap())),
  //     "products": List<dynamic>.from(products.map((x) => x)),
  //     "start_time": startTime,
  //     "shop_id": shopId,
  //     "end_time": endTime,
  //     "order": order,
  //     "classify": classify,
  //     "position": position,
  //     "vouchers": List<dynamic>.from(vouchers.map((x) => x)),
  //     "advance_actions": advanceActions,
  //     "priority": priority,
  //     "shorten_link": shortenLink,
  //     "description": description,
  // };
}

class ImageBanner {
  ImageBanner({
    required this.top,
    required this.middle,
    required this.detail,
    required this.lang,
  });

  String? top;
  String? middle;
  String? detail;
  String? lang;

  factory ImageBanner.fromJson(String str) =>
      ImageBanner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageBanner.fromMap(Map<String, dynamic> json) => ImageBanner(
        top: json["top"],
        middle: json["middle"],
        detail: json["detail"],
        lang: json["lang"],
      );

  Map<String, dynamic> toMap() => {
        "top": top,
        "middle": middle,
        "detail": detail,
        "lang": lang,
      };
}
