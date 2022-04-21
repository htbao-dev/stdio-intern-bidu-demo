import 'package:bidu_demo/data/data_providers/category_cloud_data.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:flutter/material.dart';

abstract class ICategoryRepository {
  Future<BannerAndCategory> loadBannerAndCategory();
}

class CategoryRepository implements ICategoryRepository {
  final _categoryCloudData = CategoryCloudDataSource();

  @override
  Future<BannerAndCategory> loadBannerAndCategory() async {
    try {
      final bannerAndCategory =
          await _categoryCloudData.loadBannerAndCategory();
      return bannerAndCategory;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return BannerAndCategory(listBanner: [], listCategory: []);
    }
  }
}
