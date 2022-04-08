import 'package:bidu_demo/common/server.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:http/http.dart' as http;

class HomeProvider {
  final _bannerAndCategoryUrl = 'home/banner-categories-v2/';
  final _newestProductUrl = 'home/newest-product/';
  Future<String> loadBannerAndCategory() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_bannerAndCategoryUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadNewestProduct() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_newestProductUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
