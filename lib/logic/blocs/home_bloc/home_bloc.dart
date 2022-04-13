import 'dart:async';

import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/models/suggest_product.dart';
import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc with ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();

  final RefreshController refreshController;

  final _homeEventController = StreamController<HomeEvent>();
  final _suggestProductController = StreamController<HomeState>();
  final _bannerAndCategoryController = StreamController<HomeState>();
  final _newestProductController = StreamController<HomeState>();
  final _topProductController = StreamController<HomeState>();
  final _topSearchController = StreamController<HomeState>();

  late final Stream<HomeState> _bannerAndCategoryStream;
  Stream<HomeState> get suggestProductStream =>
      _suggestProductController.stream;

  Stream<HomeState> get bannerAndCategoryStream => _bannerAndCategoryStream;
  Stream<HomeState> get newestProductStream => _newestProductController.stream;
  Stream<HomeState> get topProductStream => _topProductController.stream;
  Stream<HomeState> get topSearchStream => _topSearchController.stream;

  HomeBloc({required this.refreshController}) {
    _homeEventController.stream.listen(_mapEventToState);
    _bannerAndCategoryStream =
        _bannerAndCategoryController.stream.asBroadcastStream();
  }

  void add(HomeEvent event) {
    _homeEventController.add(event);
  }

  int _suggestCurrentPage = 1;
  int _suggestTotalPage = 99999;
  final List<Product> _suggestList = [];

  void _mapEventToState(HomeEvent event) async {
    if (event is InitLoad) {
      _loadBannerAndCategory();
      _loadNewestProduct();
      _loadTopSearch();
      _loadTopProduct();
      _loadSuggestProduct();
    } else if (event is LoadSuggestProduct) {
      _loadSuggestProduct();
    } else if (event is Refresh) {
      final newest = _loadNewestProduct();
      final topSearch = _loadTopSearch();
      final topProduct = _loadTopProduct();
      _suggestCurrentPage = 1;
      _suggestTotalPage = 99999;
      _suggestList.clear();
      final suggest = _loadSuggestProduct();
      await Future.wait([newest, topSearch, topProduct]);
      refreshController.refreshCompleted();
    }
  }

  void _loadBannerAndCategory() async {
    final bannerAndCategory = await homeRepository.loadBannerAndCategory();
    _bannerAndCategoryController.sink.add(BannerAndCategoryLoaded(
        listBanner: bannerAndCategory.listBanner,
        listCategory: bannerAndCategory.listCategory));
  }

  Future _loadNewestProduct() async {
    final listnewestProduct = await homeRepository.loadNewestProduct();
    _newestProductController.sink
        .add(NewestProductLoaded(listProduct: listnewestProduct));
  }

  Future _loadTopSearch() async {
    final listTopKeyword = await homeRepository.loadTopSearch();
    _topSearchController.sink
        .add(TopSearchLoaded(listTopKeyword: listTopKeyword));
  }

  Future _loadTopProduct() async {
    final listTopProduct = await homeRepository.loadTopProduct();
    _topProductController.sink
        .add(TopProductLoaded(listProduct: listTopProduct));
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
      _suggestProductController.sink
          .add(SuggestProductLoaded(listProduct: _suggestList));
    }
  }

  @override
  void dispose() {
    _homeEventController.close();
    _suggestProductController.close();
    _bannerAndCategoryController.close();
    _newestProductController.close();
    _topProductController.close();
    _topSearchController.close();
    super.dispose();
  }
}
