import 'package:bidu_demo/data/data_providers/category_provider.dart';
import 'package:bidu_demo/data/data_providers/product_provider.dart';
import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'dart:convert';

import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/data/models/suggest_product.dart';

class ProductRepository {
  final ProductProvider _productProvider = ProductProvider();
  final CategoryProvider _categoryProvider = CategoryProvider();

  Future<ProductDetail?> loadProductDetail(String productId) async {
    try {
      final rawData = await _productProvider.loadProductDetail(productId);
      final dataDecode = json.decode(rawData);
      if (dataDecode['success'] == true) {
        final productDetail = ProductDetail.fromMap(dataDecode['data']);
        return productDetail;
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

  Future<List<Product>> loadNewestProduct() async {
    try {
      final rawData = await _productProvider.loadNewestProduct();
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
      final rawData = await _productProvider.loadTopProduct();
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
      final rawData = await _productProvider.loadTopSearch();
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
          await _productProvider.loadSuggestProducts(page, limit, randomNumber);
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
