import 'package:bidu_demo/data/data_providers/home_provider.dart';
import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'dart:convert';

import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/suggest_product.dart';

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
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
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
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
      return [];
    }
  }

  Future<List<Product>> loadTopProduct() async {
    try {
      final rawData = await _homeProvider.loadTopProduct();
      final dataDecode = json.decode(rawData);
      if (dataDecode['success'] == true) {
        final listProduct = listProductFromMap(dataDecode['data']);
        return listProduct;
      }
      return [];
    } catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
      return [];
    }
  }

  Future<List<Keyword>> loadTopSearch() async {
    try {
      final rawData = await _homeProvider.loadTopSearch();
      final dataDecode = json.decode(rawData);
      if (dataDecode['success'] == true) {
        final listProduct = listKeywordFromMap(dataDecode['data']);
        return listProduct;
      }
      return [];
    } catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
      return [];
    }
  }

  Future<SuggestProduct?> loadSuggestProducts(
      {required int page, int limit = 20, int randomNumber = 11}) async {
    try {
      final rawData =
          await _homeProvider.loadSuggestProducts(page, limit, randomNumber);
      final dataDecode = json.decode(rawData);
      if (dataDecode['success'] == true) {
        final suggestProduct = SuggestProduct.fromMap(dataDecode);
        return suggestProduct;
      }
      return null;
    } catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
      return null;
    }
  }
}
