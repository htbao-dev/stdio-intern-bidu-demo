class User {
  User(
      {this.id,
      this.userName,
      this.avatar,
      this.email,
      this.gender,
      this.isNewbie,
      this.shortenLink,
      this.shopId,
      this.galleryImage,
      required this.followCount});

  String? id;
  String? userName;
  String? avatar;
  String? email;
  int? gender;
  bool? isNewbie;
  String? shortenLink;
  dynamic shopId;
  GalleryImage? galleryImage;
  int? followCount;

  User.fromMap(Map<String, dynamic> json)
      : this(
          id: json["_id"],
          userName: json["userName"],
          avatar: json["avatar"],
          email: json["email"],
          gender: json["gender"],
          isNewbie: json["is_newbie"],
          shortenLink: json["shorten_link"],
          shopId: json["shop_id"],
          galleryImage: json["gallery_image"] != null
              ? GalleryImage.fromMap(json["gallery_image"])
              : null,
          followCount: json["follow_count"],
        );
}

class GalleryImage {
  GalleryImage({
    required this.id,
    required this.mimeType,
    required this.products,
    required this.galleryImageAbleId,
    required this.galleryImageAbleType,
    required this.url,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String mimeType;
  List<dynamic> products;
  String galleryImageAbleId;
  String galleryImageAbleType;
  String url;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  GalleryImage.fromMap(Map<String, dynamic> json)
      : this(
          id: json["_id"],
          mimeType: json["mimeType"],
          products: List<dynamic>.from(json["products"].map((x) => x)),
          galleryImageAbleId: json["galleryImageAbleId"],
          galleryImageAbleType: json["galleryImageAbleType"],
          url: json["url"],
          isActive: json["isActive"],
          createdAt: DateTime.parse(json["createdAt"]),
          updatedAt: DateTime.parse(json["updatedAt"]),
        );
}
