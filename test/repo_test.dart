import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test home repository', () {
    HomeRepository bannerRepository = HomeRepository();
    test('test banner_category', () async {
      expect(await bannerRepository.loadBannerAndCategory(), isNotNull);
    });
    test('test newest product', () async {
      var res = await bannerRepository.loadNewestProduct();
      expect(res, isNotEmpty);
    });
  });
}
