import 'package:bidu_demo/data/data_providers/home_provider.dart';
import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'dart:convert';

import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/presentation/widget/home_product.dart';

class HomeRepository {
  final HomeProvider _homeProvider = HomeProvider();
  Future<BannerAndCategory> loadBannerAndCategory() async {
    try {
      final rawData = await _homeProvider.loadBannerAndCategory();
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

  Future<List<Product>> loadNewestProduct() async {
    try {
      final rawData = await _homeProvider.loadNewestProduct();
      final dataDecode = json.decode(rawData);
      if (dataDecode['success'] == true) {
        final listProduct = listProductFromMap(dataDecode['data']);
        return listProduct;
      }
      return [];
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }
}
