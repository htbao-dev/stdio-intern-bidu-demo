import 'package:bidu_demo/common/server.dart';
import 'package:http/http.dart' as http;

class CategoryProvider {
  final _bannerAndCategoryUrl = 'api/v2/mobile/home/banner-categories-v2';
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
}
