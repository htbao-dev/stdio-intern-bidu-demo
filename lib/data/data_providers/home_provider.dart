import 'package:bidu_demo/common/server.dart';
import 'package:http/http.dart' as http;

class HomeProvider {
  final _bannerAndCategoryUrl = 'api/v2/mobile/home/banner-categories-v2/';
  final _newestProductUrl = 'api/v2/mobile/home/newest-product/';
  final _topProductUrl = 'api/v2/mobile/home/top-product/';
  final _topSearchUrl = 'api/v2/mobile/home/top-keyword/';

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

  Future<String> loadTopProduct() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_topProductUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadTopSearch() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_topSearchUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
