import 'package:bidu_demo/common/server.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  final _newestProductUrl = 'api/v2/mobile/home/newest-product';
  final _topProductUrl = 'api/v2/mobile/home/top-product';
  final _topSearchUrl = 'api/v2/mobile/home/top-keyword';
  final _suggestProductUrl = 'api/v2/mobile/suggest-products';
  final _productDetailUrl = 'api/v1/mobile/products/';

  Future<String> loadProductDetail(String productId) async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_productDetailUrl$productId'),
        headers: {
          'Authorization':
              'Bidu eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNTI5YWEyMzU4M2E5MDAxOTBiMTg0ZSIsImlhdCI6MTY0NTY5NjEyNCwiZXhwIjoxNjc3MjMyMTI0fQ.1dkYz3sf1KxxciFBLoamHO0Y_5XDRn5L9kCipmV7F-w',
        },
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadNewestProduct() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_newestProductUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadTopProduct() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_topProductUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadTopSearch() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint$_topSearchUrl'),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadSuggestProducts(
      int page, int limit, int randomNumber) async {
    try {
      final String url =
          '$endPoint$_suggestProductUrl?page=$page&limit=$limit&random_number=$randomNumber';
      final response = await http.get(
        Uri.parse(url),
      );
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
