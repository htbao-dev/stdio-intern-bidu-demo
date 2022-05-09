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
    required String? country,
    this.name,
    this.description,
    this.userId,
    this.ranking,
    this.rankingToday,
    this.rankingYesterday,
    this.avgRating,
    this.rankPolicy,
    this.rankingCriteria,
    this.user,
    this.avgShippingTime,
  }) {
    _country = country;
  }

  String id;
  int? shopType;
  String? _country;
  String? name;
  String? description;
  String? userId;
  int? ranking;
  int? rankingToday;
  int? rankingYesterday;
  double? avgRating;
  RankPolicy? rankPolicy;
  RankingCriteria? rankingCriteria;
  User? user;
  AvgShippingTime? avgShippingTime;

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
          country: json["country"],
          name: json["name"],
          description: json["description"],
          userId: json["user_id"],
          ranking: json["ranking"],
          rankingToday: json["ranking_today"],
          rankingYesterday: json["ranking_yesterday"],
          avgRating: json["avg_rating"]?.toDouble(),
          rankPolicy: json["rank_policy"] != null
              ? RankPolicy.fromMap(json["rank_policy"])
              : null,
          rankingCriteria: json["ranking_criteria"] != null
              ? RankingCriteria.fromMap(json["ranking_criteria"])
              : null,
          user: json["user"] != null ? User.fromMap(json["user"]) : null,
          avgShippingTime: json["avg_shipping_time"] != null
              ? AvgShippingTime.fromMap(json["avg_shipping_time"])
              : null,
        );
}

class AvgShippingTime {
  final int min;
  final int max;

  AvgShippingTime({required this.min, required this.max});

  AvgShippingTime.fromMap(Map<String, dynamic> json)
      : this(
          min: json["min"],
          max: json["max"],
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
  double lateDelivery;
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
          lateDelivery: json["lateDelivery"].toDouble(),
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
  double mark;
  RankingCriteria.fromMap(Map<String, dynamic> json)
      : this(
          totalVenue: json["total_venue"],
          totalOrder: json["total_order"],
          rating: json["rating"].toDouble(),
          mark: json["mark"].toDouble(),
        );

  Map<String, dynamic> toMap() => {
        "total_venue": totalVenue,
        "total_order": totalOrder,
        "rating": rating,
        "mark": mark,
      };
}
