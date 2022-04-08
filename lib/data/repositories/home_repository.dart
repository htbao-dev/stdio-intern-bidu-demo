import 'package:bidu_demo/data/data_providers/banner_provider.dart';
import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'dart:convert';

import 'package:bidu_demo/data/models/category.dart';

class HomeRepository {
  final BannerProvider _bannerProvider = BannerProvider();
  Future<BannerAndCategory> loadBannerAndCategory() async {
    try {
      final rawData = await _bannerProvider.loadBannerAndCategory();
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
      print(e);
      print(s);
      return BannerAndCategory(listBanner: [], listCategory: []);
    }
  }
}
