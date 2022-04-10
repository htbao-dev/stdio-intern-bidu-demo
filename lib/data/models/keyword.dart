import 'dart:convert';

List<Keyword> listKeywordFromMap(List<dynamic> data) {
  return List<Keyword>.from(data.map((x) => Keyword.fromMap(x)));
}

class Keyword {
  Keyword({
    required this.countNumber,
    required this.id,
    required this.keyword,
    required this.shopId,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.totalProduct,
  });

  int countNumber;
  String id;
  String keyword;
  dynamic shopId;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;
  int totalProduct;

  factory Keyword.fromJson(String str) => Keyword.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Keyword.fromMap(Map<String, dynamic> json) => Keyword(
        countNumber: json["count_number"],
        id: json["_id"],
        keyword: json["keyword"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        avatar: json["avatar"],
        totalProduct: json["total_product"],
      );

  Map<String, dynamic> toMap() => {
        "count_number": countNumber,
        "_id": id,
        "keyword": keyword,
        "shop_id": shopId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "avatar": avatar,
        "total_product": totalProduct,
      };
}
