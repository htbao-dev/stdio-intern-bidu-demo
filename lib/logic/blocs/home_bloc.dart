import 'dart:async';

import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/suggest_product.dart';
import 'package:bidu_demo/data/repositories/category_repository.dart';
import 'package:bidu_demo/data/repositories/product_repository.dart';

class HomeBloc {
  final IProductRepository productRepository;
  final ICategoryRepository categoryRepository;
  bool _backToTop = false;
  final _suggestProductController = StreamController<List<Product>>();
  final _bannerAndCategoryController = StreamController<BannerAndCategory>();
  final _newestProductController = StreamController<List<Product>>();
  final _topProductController = StreamController<List<Product>>();
  final _topSearchController = StreamController<List<Keyword>>();
  final _backToTopController = StreamController<bool>();
  final _bannerIndicatorController = StreamController<int>();
  late final Stream<BannerAndCategory> _bannerAndCategoryStream;

  Stream<int> get bannerIndicatorStream => _bannerIndicatorController.stream;
  Stream<List<Product>> get suggestProductStream =>
      _suggestProductController.stream;
  Stream<BannerAndCategory> get bannerAndCategoryStream =>
      _bannerAndCategoryStream;
  Stream<List<Product>> get newestProductStream =>
      _newestProductController.stream;
  Stream<List<Product>> get topProductStream => _topProductController.stream;
  Stream<List<Keyword>> get topSearchStream => _topSearchController.stream;
  Stream<bool> get backToTopStream => _backToTopController.stream;

  HomeBloc({
    required this.productRepository,
    required this.categoryRepository,
  }) {
    _bannerAndCategoryStream =
        _bannerAndCategoryController.stream.asBroadcastStream();
  }

  int _suggestCurrentPage = 1;
  int _suggestTotalPage = 1;
  final List<Product> _suggestList = [];

  void initLoad() {
    _loadBannerAndCategory();
    _loadNewestProduct();
    _loadTopSearch();
    _loadTopProduct();
    _loadSuggestProduct();
  }

  void loadSuggestProduct() {
    _loadSuggestProduct();
  }

  void onBannerChanged(int index) {
    _bannerIndicatorController.sink.add(index);
  }

  Future refesh() async {
    _suggestCurrentPage = 1;
    _suggestTotalPage = 1;
    _suggestList.clear();

    final _newest = _loadNewestProduct();
    final _topSearch = _loadTopSearch();
    final topProduct = _loadTopProduct();
    final suggest = _loadSuggestProduct();
    await Future.wait([_newest, _topSearch, topProduct, suggest]);
    return;
  }

  void showBackToTop(bool isShow) {
    _backToTop = isShow;
    _backToTopController.sink.add(_backToTop);
  }

  Future _loadBannerAndCategory() async {
    final bannerAndCategory = await categoryRepository.loadBannerAndCategory();
    _bannerAndCategoryController.sink.add(bannerAndCategory);
  }

  Future _loadNewestProduct() async {
    final listnewestProduct = await productRepository.loadNewestProduct();
    _newestProductController.sink.add(listnewestProduct);
  }

  Future _loadTopSearch() async {
    final listTopKeyword = await productRepository.loadTopSearch();
    _topSearchController.sink.add(listTopKeyword);
  }

  Future _loadTopProduct() async {
    final listTopProduct = await productRepository.loadTopProduct();
    _topProductController.sink.add(listTopProduct);
  }

  Future _loadSuggestProduct() async {
    final SuggestProduct? suggestProduct;
    if (_suggestCurrentPage <= _suggestTotalPage) {
      suggestProduct = await productRepository.loadSuggestProducts(
          page: _suggestCurrentPage + 1);
      if (suggestProduct != null) {
        _suggestCurrentPage = suggestProduct.currentPage;
        _suggestTotalPage = suggestProduct.totalPage;
        _suggestList.addAll(suggestProduct.listProduct);
      }
      _suggestProductController.sink.add(_suggestList);
    }
  }

  void dispose() {
    _suggestProductController.close();
    _bannerAndCategoryController.close();
    _newestProductController.close();
    _topProductController.close();
    _topSearchController.close();
    _backToTopController.close();
  }
}
