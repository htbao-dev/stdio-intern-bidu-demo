import 'package:bidu_demo/common/server.dart';
import 'package:http/http.dart' as http;

class HomeProvider {
  final _bannerAndCategoryUrl = 'api/v2/mobile/home/banner-categories-v2';
  final _newestProductUrl = 'api/v2/mobile/home/newest-product';
  final _topProductUrl = 'api/v2/mobile/home/top-product';
  final _topSearchUrl = 'api/v2/mobile/home/top-keyword';
  final _suggestProductUrl = 'api/v2/mobile/suggest-products';

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

  Future<String> loadSuggestProducts(
      int page, int limit, int randomNumber) async {
    try {
      final String url =
          '$endPoint$_suggestProductUrl?page=$page&limit=$limit&random_number=$randomNumber';
      final response = await http.get(
        Uri.parse(url),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
