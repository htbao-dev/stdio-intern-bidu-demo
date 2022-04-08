import 'package:bidu_demo/common/server.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:http/http.dart' as http;

class BannerProvider {
  final _bannerAndCategoryUrl = 'home/banner-categories-v2/';
  Future<String> loadBannerAndCategory() async {
    try {
      print('$endPoint$_bannerAndCategoryUrl');
      final response = await http.get(
        Uri.parse('$endPoint$_bannerAndCategoryUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
