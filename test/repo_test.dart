import 'package:bidu_demo/data/repositories/product_repository.dart';
import 'package:bidu_demo/data/repositories/category_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test product repository', () {
    ProductRepository productRepository = ProductRepository();
    test('test newest product', () async {
      var res = await productRepository.loadNewestProduct();
      expect(res, isNotEmpty);
    });
    test('test top product', () async {
      var res = await productRepository.loadTopProduct();
      expect(res, isNotEmpty);
    });

    test('test top keyword', () async {
      var res = await productRepository.loadTopSearch();
      expect(res, isNotEmpty);
    });

    test('test suggest product', () async {
      var res = await productRepository.loadSuggestProducts(page: 1);
      expect(res, isNotNull);
    });
    test('test product detail', () async {
      var res =
          await productRepository.loadProductDetail('621307d6e817a50012f5bb57');
      expect(res, isNotNull);
    });
    test('test top seller', () async {
      var res = await productRepository.loadTopSeller();
      expect(res, isNotEmpty);
    });
  });

  group('test category repo', () {
    CategoryRepository categoryRepository = CategoryRepository();
    test('test banner_category', () async {
      expect(await categoryRepository.loadBannerAndCategory(), isNotNull);
    });
  });
}
