import 'package:bidu_demo/data/data_providers/product_cloud_data.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/data/models/suggest_product.dart';
import 'package:flutter/widgets.dart';

abstract class IProductRepository {
  Future<List<Product>> loadNewestProduct();
  Future<List<Product>> loadTopProduct();
  Future<List<Keyword>> loadTopSearch();
  Future<SuggestProduct?> loadSuggestProducts(
      {required int page, int limit, int randomNumber});
  Future<ProductDetail?> loadProductDetail(String productId);
}

class ProductRepository implements IProductRepository {
  final ProductCloudDataSource _productCloudData = ProductCloudDataSource();

  @override
  Future<ProductDetail?> loadProductDetail(String productId) async {
    try {
      final productDetail =
          await _productCloudData.loadProductDetail(productId);
      return productDetail;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return null;
    }
  }

  @override
  Future<List<Product>> loadNewestProduct() async {
    try {
      final listProudct = await _productCloudData.loadNewestProduct();
      return listProudct;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return [];
    }
  }

  @override
  Future<List<Product>> loadTopProduct() async {
    try {
      final listProduct = await _productCloudData.loadTopProduct();
      return listProduct;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return [];
    }
  }

  @override
  Future<List<Keyword>> loadTopSearch() async {
    try {
      final listKeyword = await _productCloudData.loadTopSearch();
      return listKeyword;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return [];
    }
  }

  @override
  Future<SuggestProduct?> loadSuggestProducts(
      {required int page, int limit = 20, int randomNumber = 11}) async {
    try {
      final suggestProduct = await _productCloudData.loadSuggestProducts(
          page, limit, randomNumber);
      return suggestProduct;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return null;
    }
  }
}
