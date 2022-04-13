import 'dart:async';

import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc with ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();

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

  HomeBloc() {
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
    if (event is LoadBannerAndCategory) {
      final bannerAndCategory = await homeRepository.loadBannerAndCategory();
      _bannerAndCategoryController.sink.add(BannerAndCategoryLoaded(
          listBanner: bannerAndCategory.listBanner,
          listCategory: bannerAndCategory.listCategory));
    } else if (event is LoadNewestProduct) {
      final listnewestProduct = await homeRepository.loadNewestProduct();
      _newestProductController.sink
          .add(NewestProductLoaded(listProduct: listnewestProduct));
    } else if (event is LoadTopSearch) {
      final listTopKeyword = await homeRepository.loadTopSearch();
      _topSearchController.sink
          .add(TopSearchLoaded(listTopKeyword: listTopKeyword));
    } else if (event is LoadTopProduct) {
      final listTopProduct = await homeRepository.loadTopProduct();
      _topProductController.sink
          .add(TopProductLoaded(listProduct: listTopProduct));
    } else if (event is LoadSuggestProduct) {
      if (_suggestCurrentPage <= _suggestTotalPage) {
        final suggestProduct = await homeRepository.loadSuggestProducts(
            page: _suggestCurrentPage + 1);
        if (suggestProduct != null) {
          _suggestCurrentPage = suggestProduct.currentPage;
          _suggestTotalPage = suggestProduct.totalPage;
          _suggestList.addAll(suggestProduct.listProduct);
          _suggestProductController.sink
              .add(SuggestProductLoaded(listProduct: _suggestList));
        } else {
          _suggestProductController.sink
              .add(const SuggestProductLoaded(listProduct: []));
        }
      }
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
