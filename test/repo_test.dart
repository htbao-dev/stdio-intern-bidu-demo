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
    test('test top product', () async {
      var res = await bannerRepository.loadTopProduct();
      expect(res, isNotEmpty);
    });

    test('test top keyword', () async {
      var res = await bannerRepository.loadTopSearch();
      expect(res, isNotEmpty);
    });
  });
}
