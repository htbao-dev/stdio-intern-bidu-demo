import 'dart:async';

import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/suggest_product.dart';
import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc {
  final HomeRepository homeRepository;
  bool _backToTop = false;
  final _suggestProductController = StreamController<List<Product>>();
  final _bannerAndCategoryController = StreamController<BannerAndCategory>();
  final _newestProductController = StreamController<List<Product>>();
  final _topProductController = StreamController<List<Product>>();
  final _topSearchController = StreamController<List<Keyword>>();
  final _backToTopController = StreamController<bool>();

  late final Stream<BannerAndCategory> _bannerAndCategoryStream;

  Stream<List<Product>> get suggestProductStream =>
      _suggestProductController.stream;
  Stream<BannerAndCategory> get bannerAndCategoryStream =>
      _bannerAndCategoryStream;
  Stream<List<Product>> get newestProductStream =>
      _newestProductController.stream;
  Stream<List<Product>> get topProductStream => _topProductController.stream;
  Stream<List<Keyword>> get topSearchStream => _topSearchController.stream;
  Stream<bool> get backToTopStream => _backToTopController.stream;

  HomeBloc({required this.homeRepository}) {
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

  void refesh() async {
    _loadNewestProduct();
    _loadTopSearch();
    _loadTopProduct();
    _suggestCurrentPage = 1;
    _suggestTotalPage = 1;
    _suggestList.clear();
    _loadSuggestProduct();
  }

  void showBackToTop(bool isShow) {
    _backToTop = isShow;
    _backToTopController.sink.add(_backToTop);
  }

  Future _loadBannerAndCategory() async {
    final bannerAndCategory = await homeRepository.loadBannerAndCategory();
    _bannerAndCategoryController.sink.add(bannerAndCategory);
  }

  Future _loadNewestProduct() async {
    final listnewestProduct = await homeRepository.loadNewestProduct();
    _newestProductController.sink.add(listnewestProduct);
  }

  Future _loadTopSearch() async {
    final listTopKeyword = await homeRepository.loadTopSearch();
    _topSearchController.sink.add(listTopKeyword);
  }

  Future _loadTopProduct() async {
    final listTopProduct = await homeRepository.loadTopProduct();
    _topProductController.sink.add(listTopProduct);
  }

  Future _loadSuggestProduct() async {
    final SuggestProduct? suggestProduct;
    if (_suggestCurrentPage <= _suggestTotalPage) {
      suggestProduct = await homeRepository.loadSuggestProducts(
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
