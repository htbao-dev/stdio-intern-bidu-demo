import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/shop.dart';
import 'package:bidu_demo/data/models/user.dart';

class ProductDetail extends Product {
  List<TimePrepareOrder>? timePrepareOrder;
  String? description;
  Feedbacks feedbacks;
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
    required this.feedbacks,
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
          feedbacks: Feedbacks.fromMap(json["feedbacks"]),
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

class Feedbacks {
  Feedbacks({
    required this.averageFeedbackRate,
    required this.totalFeedback,
    required this.totalByMedia,
    required this.totalByComment,
    required this.totalByStar,
    required this.feedbackMedias,
    required this.satisfactionRate,
    required this.feedbacks,
  });

  double? averageFeedbackRate;
  int? totalFeedback;
  int? totalByMedia;
  int? totalByComment;
  List<TotalByStar>? totalByStar;
  List<dynamic>? feedbackMedias;
  double? satisfactionRate;
  List<Feedback>? feedbacks;

  factory Feedbacks.fromMap(Map<String, dynamic> json) {
    return Feedbacks(
      averageFeedbackRate: json["averageFeedbackRate"]?.toDouble(),
      totalFeedback: json["totalFeedback"],
      totalByMedia: json["totalByMedia"],
      totalByComment: json["totalByComment"],
      totalByStar: List<TotalByStar>.from(
          json["totalByStar"].map((x) => TotalByStar.fromMap(x))),
      feedbackMedias: List<dynamic>.from(json["feedbackMedias"].map((x) => x)),
      satisfactionRate: json["satisfactionRate"]?.toDouble(),
      feedbacks: List<Feedback>.from(
          json["feedbacks"].map((x) => Feedback.fromMap(x))),
    );
  }
}

class TotalByStar {
  TotalByStar({
    required this.total,
    required this.voteStar,
  });

  int total;
  int voteStar;

  factory TotalByStar.fromMap(Map<String, dynamic> json) => TotalByStar(
        total: json["total"],
        voteStar: json["vote_star"],
      );
}

class Feedback {
  Feedback({
    required this.totalLike,
    required this.shop,
    required this.targetType,
    required this.createdAt,
    required this.targetId,
    required this.voteStar,
    required this.content,
    required this.medias,
    required this.shopId,
    required this.userLiked,
    required this.isShowBodyShape,
    required this.updatedAt,
    required this.userId,
    required this.isPublic,
    required this.variant,
    required this.isApproved,
    required this.id,
    required this.orderId,
    required this.user,
    required this.isLiked,
  });

  int totalLike;
  Shop shop;
  String targetType;
  String createdAt;
  String targetId;
  int voteStar;
  String content;
  List<dynamic> medias;
  String shopId;
  List<dynamic> userLiked;
  bool isShowBodyShape;
  String updatedAt;
  String userId;
  bool isPublic;
  dynamic variant;
  bool isApproved;
  String id;
  String orderId;
  User user;
  bool isLiked;

  factory Feedback.fromMap(Map<String, dynamic> json) => Feedback(
        totalLike: json["total_like"],
        shop: Shop.fromMap(json["shop"]),
        targetType: json["target_type"],
        createdAt: json["created_at"],
        targetId: json["target_id"],
        voteStar: json["vote_star"],
        content: json["content"],
        medias: List<dynamic>.from(json["medias"].map((x) => x)),
        shopId: json["shop_id"],
        userLiked: List<dynamic>.from(json["user_liked"].map((x) => x)),
        isShowBodyShape: json["is_show_body_shape"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
        isPublic: json["is_public"],
        variant: json["variant"],
        isApproved: json["is_approved"],
        id: json["_id"],
        orderId: json["order_id"],
        user: User.fromMap(json["user"]),
        isLiked: json["is_liked"],
      );
}

class Data {
  Data({
    required this.unSuccessOrderByPercent,
    required this.shopRating,
    required this.numberOfBuyers,
    required this.penaltyOrderByPercent,
    required this.chatResponseByPercent,
    required this.lateDelivery,
    required this.totalOrders,
    required this.successOrderByPercent,
    required this.preOrderByPercent,
  });

  double unSuccessOrderByPercent;
  int shopRating;
  int numberOfBuyers;
  int penaltyOrderByPercent;
  int chatResponseByPercent;
  int lateDelivery;
  int totalOrders;
  double successOrderByPercent;
  int preOrderByPercent;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        unSuccessOrderByPercent: json["unSuccessOrderByPercent"].toDouble(),
        shopRating: json["shopRating"],
        numberOfBuyers: json["numberOfBuyers"],
        penaltyOrderByPercent: json["penaltyOrderByPercent"],
        chatResponseByPercent: json["chatResponseByPercent"],
        lateDelivery: json["lateDelivery"],
        totalOrders: json["totalOrders"],
        successOrderByPercent: json["successOrderByPercent"].toDouble(),
        preOrderByPercent: json["preOrderByPercent"],
      );
}

class NameOrganizer {
  NameOrganizer({
    required this.unsigneduserName,
    required this.userName,
  });

  String unsigneduserName;
  String userName;

  factory NameOrganizer.fromMap(Map<String, dynamic> json) => NameOrganizer(
        unsigneduserName: json["unsigneduserName"],
        userName: json["userName"],
      );
}

enum TimePrepareOrderDay {
  oneDay,
  twoDay,
  threeDay,
  fourDay,
  greaterThanFourDay
}
