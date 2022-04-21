import 'package:bidu_demo/data/models/user.dart';

List<Shop> listShopFromMap(List<dynamic> listMap) {
  List<Shop> listShop = [];
  for (var map in listMap) {
    listShop.add(Shop.fromMap(map));
  }
  return listShop;
}

class Shop {
  Shop({
    required this.id,
    this.shopType,
    // required this.refundMoneyMode,
    // required this.refundMoneyRegulations,
    // required this.pauseMode,
    required String? country,
    // required this.isApproved,
    this.name,
    this.description,
    this.userId,
    // required this.shippingMethods,
    // required this.refundConditions,
    // required this.createdAt,
    // required this.updatedAt,
    this.ranking,
    this.rankingToday,
    this.rankingYesterday,
    this.avgRating,
    // required this.shortenLink,
    // required this.allowShowOnTop,
    this.rankPolicy,
    this.rankingCriteria,
    // required this.systemBanner,
    // required this.middleBanner,
    // required this.avgShippedTime,
    // required this.biggestPrice,
    this.user,
  }) {
    _country = country;
  }

  String id;
  int? shopType;
  // bool refundMoneyMode;
  // dynamic refundMoneyRegulations;
  // bool pauseMode;
  String? _country;
  // bool isApproved;
  String? name;
  String? description;
  String? userId;
  // List<ShippingMethod> shippingMethods;
  // List<dynamic> refundConditions;
  // DateTime createdAt;
  // DateTime updatedAt;
  int? ranking;
  int? rankingToday;
  int? rankingYesterday;
  double? avgRating;
  // String shortenLink;
  // bool allowShowOnTop;
  RankPolicy? rankPolicy;
  RankingCriteria? rankingCriteria;
  // dynamic systemBanner;
  // String middleBanner;
  // int avgShippedTime;
  // int biggestPrice;
  User? user;

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
          shopType: json["shop_type"],
          // refundMoneyMode: json["refund_money_mode"],
          // refundMoneyRegulations: json["refund_money_regulations"],
          // pauseMode: json["pause_mode"],
          country: json["country"],
          // isApproved: json["is_approved"],
          name: json["name"],
          description: json["description"],
          userId: json["user_id"],
          // shippingMethods: List<ShippingMethod>.from(
          //     json["shipping_methods"].map((x) => ShippingMethod.fromMap(x))),
          // refundConditions:
          //     List<dynamic>.from(json["refund_conditions"].map((x) => x)),
          // createdAt: DateTime.parse(json["createdAt"]),
          // updatedAt: DateTime.parse(json["updatedAt"]),
          ranking: json["ranking"],
          rankingToday: json["ranking_today"],
          rankingYesterday: json["ranking_yesterday"],
          avgRating: json["avg_rating"]?.toDouble(),
          // shortenLink: json["shorten_link"],
          // allowShowOnTop: json["allow_show_on_top"],
          rankPolicy: json["rank_policy"] != null
              ? RankPolicy.fromMap(json["rank_policy"])
              : null,
          rankingCriteria: json["ranking_criteria"] != null
              ? RankingCriteria.fromMap(json["ranking_criteria"])
              : null,
          // systemBanner: json["system_banner"],
          // middleBanner: json["middle_banner"],
          // avgShippedTime: json["avg_shipped_time"],
          // biggestPrice: json["biggest_price"],
          user: json["user"] != null ? User.fromMap(json["user"]) : null,
        );
}

class RankPolicy {
  RankPolicy({
    required this.name,
    required this.data,
  });

  dynamic name;
  Data data;

  RankPolicy.fromMap(Map<String, dynamic> json)
      : this(
          name: json["name"],
          data: Data.fromMap(json["data"]),
        );
}

class Data {
  Data({
    required this.numberOfBuyers,
    required this.totalOrders,
    required this.successOrderByPercent,
    required this.chatResponseByPercent,
    required this.shopRating,
    required this.unSuccessOrderByPercent,
    required this.lateDelivery,
    required this.penaltyOrderByPercent,
    required this.preOrderByPercent,
  });

  int numberOfBuyers;
  int totalOrders;
  double successOrderByPercent;
  int chatResponseByPercent;
  double shopRating;
  double unSuccessOrderByPercent;
  int lateDelivery;
  double penaltyOrderByPercent;
  int preOrderByPercent;

  Data.fromMap(Map<String, dynamic> json)
      : this(
          numberOfBuyers: json["numberOfBuyers"],
          totalOrders: json["totalOrders"],
          successOrderByPercent: json["successOrderByPercent"].toDouble(),
          chatResponseByPercent: json["chatResponseByPercent"],
          shopRating: json["shopRating"].toDouble(),
          unSuccessOrderByPercent: json["unSuccessOrderByPercent"].toDouble(),
          lateDelivery: json["lateDelivery"],
          penaltyOrderByPercent: json["penaltyOrderByPercent"].toDouble(),
          preOrderByPercent: json["preOrderByPercent"],
        );
}

class RankingCriteria {
  RankingCriteria({
    required this.totalVenue,
    required this.totalOrder,
    required this.rating,
    required this.mark,
  });

  int totalVenue;
  int totalOrder;
  double rating;
  int mark;
  RankingCriteria.fromMap(Map<String, dynamic> json)
      : this(
          totalVenue: json["total_venue"],
          totalOrder: json["total_order"],
          rating: json["rating"].toDouble(),
          mark: json["mark"],
        );

  Map<String, dynamic> toMap() => {
        "total_venue": totalVenue,
        "total_order": totalOrder,
        "rating": rating,
        "mark": mark,
      };
}
