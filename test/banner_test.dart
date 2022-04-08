import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test banner_category', () {
    test('test banner_category', () async {
      HomeRepository bannerRepository = HomeRepository();
      expect(await bannerRepository.loadBannerAndCategory(), isNotNull);
    });
  });
}
