import 'dart:convert';

import 'package:bidu_demo/data/data_providers/category_provider.dart';
import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:bidu_demo/data/models/category.dart';

class CategoryRepository {
  final _categoryProvider = CategoryProvider();

  Future<BannerAndCategory> loadBannerAndCategory() async {
    try {
      final rawData = await _categoryProvider.loadBannerAndCategory();
      final dataDecode = json.decode(rawData);
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
    } catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
      return BannerAndCategory(listBanner: [], listCategory: []);
    }
  }
}
