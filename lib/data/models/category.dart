import 'dart:convert';

List<Category> listCaterogyFromMap(List<dynamic> json) {
  return List<Category>.from(json.map((item) => Category.fromMap(item)));
}

class Category {
  Category({
    required this.id,
    required this.name,
    // @required this.nameLocalized,
    required this.shopId,
    // @required this.permalink,
    required this.parentId,
    required this.priority,
    required this.childs,
    required this.isActive,
    required this.avatar,
    required this.pdfAvatar,
  });

  String id;
  String name;
  String? shopId;
  String? parentId;
  int? priority;
  dynamic childs;
  bool isActive;
  String avatar;
  String pdfAvatar;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        shopId: json["shop_id"],
        parentId: json["parent_id"],
        priority: json["priority"],
        childs: json["childs"],
        isActive: json["is_active"],
        avatar: json["avatar"],
        pdfAvatar: json["pdfAvatar"],
      );
}
