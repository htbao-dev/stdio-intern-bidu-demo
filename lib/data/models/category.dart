import 'dart:convert';

List<Category> listCaterogyFromMap(List<dynamic> json) {
  return List<Category>.from(json.map((item) => Category.fromMap(item)));
}

class Category {
  Category({
    this.id,
    required this.name,
    this.shopId,
    this.parentId,
    this.priority,
    this.childs,
    this.isActive,
    required this.avatar,
    this.pdfAvatar,
  });

  String? id;
  String name;
  String? shopId;
  String? parentId;
  int? priority;
  dynamic childs;
  bool? isActive;
  String avatar;
  String? pdfAvatar;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  Category.fromMap(Map<String, dynamic> json)
      : this(
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
