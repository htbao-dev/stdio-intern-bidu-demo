import 'dart:convert';

import 'package:bidu_demo/common/server.dart';
import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:bidu_demo/data/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryCloudDataSource {
  final _bannerAndCategoryUrl = 'api/v2/mobile/home/banner-categories-v2';
  Future<BannerAndCategory> loadBannerAndCategory() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_bannerAndCategoryUrl'),
      );
      final dataDecode = json.decode(response.body);
      if (dataDecode['success'] == true) {
        final listBanner =
            listBannerFromMap(dataDecode['data']['system_banner']);

        final listCategory =
            listCaterogyFromMap(dataDecode['data']['system_category']);
        return BannerAndCategory(
          listBanner: listBanner,
          listCategory: listCategory,
        );
      }
      return BannerAndCategory(listBanner: [], listCategory: []);
    } catch (e) {
      rethrow;
    }
  }
}
