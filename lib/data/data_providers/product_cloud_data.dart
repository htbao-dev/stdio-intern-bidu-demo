import 'dart:convert';

import 'package:bidu_demo/common/server.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/data/models/shop.dart';
import 'package:bidu_demo/data/models/suggest_product.dart';
import 'package:http/http.dart' as http;

class ProductCloudDataSource {
  final _newestProductUrl = 'api/v2/mobile/home/newest-product';
  final _topProductUrl = 'api/v2/mobile/home/top-product';
  final _topSearchUrl = 'api/v2/mobile/home/top-keyword';
  final _suggestProductUrl = 'api/v2/mobile/suggest-products';
  final _productDetailUrl = 'api/v1/mobile/products/';
  final _productDetailUrl1 = 'api/v1/mobile/product-explores/';
  final _topSellerUrl = 'api/v1/mobile/home/ranking-seller/';
  final _rankingUrl = '/api/v1/mobile/home/ranking';

  Future<ProductDetail?> loadProductDetail(String productId) async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_productDetailUrl1$productId'),
        // headers: {
        //   'Authorization':
        //       'Bidu eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNTI5YWEyMzU4M2E5MDAxOTBiMTg0ZSIsImlhdCI6MTY0NTY5NjEyNCwiZXhwIjoxNjc3MjMyMTI0fQ.1dkYz3sf1KxxciFBLoamHO0Y_5XDRn5L9kCipmV7F-w',
        // },
      );
      print(response.body);
      final dataDecode = json.decode(response.body);
      if (dataDecode['success'] == true) {
        final productDetail = ProductDetail.fromMap(dataDecode['data']);
        return productDetail;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> loadNewestProduct() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_newestProductUrl'),
      );
      final dataDecode = json.decode(response.body);
      if (dataDecode['success'] == true) {
        final listProduct = listProductFromMap(dataDecode['data']);
        return listProduct;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> loadTopProduct() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_topProductUrl'),
      );
      final dataDecode = json.decode(response.body);
      if (dataDecode['success'] == true) {
        final listProduct = listProductFromMap(dataDecode['data']);
        return listProduct;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Keyword>> loadTopSearch() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_topSearchUrl'),
      );
      final dataDecode = json.decode(response.body);
      if (dataDecode['success'] == true) {
        final listKeyword = listKeywordFromMap(dataDecode['data']);
        return listKeyword;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<SuggestProduct?> loadSuggestProducts(
      int page, int limit, int randomNumber) async {
    try {
      final String url =
          '$endPoint$_suggestProductUrl?page=$page&limit=$limit&random_number=$randomNumber';
      final response = await http.get(
        Uri.parse(url),
      );
      final dataDecode = json.decode(response.body);
      if (dataDecode['success'] == true) {
        final suggestProduct = SuggestProduct.fromMap(dataDecode);
        return suggestProduct;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Shop>> loadTopSeller(int page, int limit) async {
    try {
      final String url = '$endPoint$_topSellerUrl?page=$page&limit=$limit';
      final response = await http.get(
        Uri.parse(url),
      );
      final dataDecode = json.decode(response.body);
      if (dataDecode['success'] == true) {
        final listShop = listShopFromMap(dataDecode['data']);
        return listShop;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
