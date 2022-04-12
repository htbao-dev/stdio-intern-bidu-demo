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
  final _homeEventController = StreamController<HomeEvent>();
  final _homeStateController = StreamController<HomeState>();
  final HomeRepository homeRepository = HomeRepository();

  late final Stream<HomeState> _stream;
  // late final Stream<HomeState> _stream;

  Stream<HomeState> get stream => _stream;
  Stream<HomeState> get bannerAndCategoryStream =>
      _stream.where((event) => event is BannerAndCategoryLoaded);
  Stream<HomeState> get newestProductStream =>
      _stream.where((event) => event is NewestProductLoaded);
  Stream<HomeState> get topProductStream =>
      _stream.where((event) => event is TopProductLoaded);
  Stream<HomeState> get topSearchStream =>
      _stream.where((event) => event is TopSearchLoaded);

  HomeBloc() {
    _homeEventController.stream.listen(_mapEventToState);
    _stream = _homeStateController.stream.asBroadcastStream();
  }

  void add(HomeEvent event) {
    _homeEventController.add(event);
  }

  void _mapEventToState(HomeEvent event) async {
    if (event is LoadBannerAndCategory) {
      final bannerAndCategory = await homeRepository.loadBannerAndCategory();
      _homeStateController.sink.add(BannerAndCategoryLoaded(
          listBanner: bannerAndCategory.listBanner,
          listCategory: bannerAndCategory.listCategory));
    } else if (event is LoadNewestProduct) {
      final listnewestProduct = await homeRepository.loadNewestProduct();
      _homeStateController.sink
          .add(NewestProductLoaded(listProduct: listnewestProduct));
    } else if (event is LoadTopProduct) {
      final listTopProduct = await homeRepository.loadTopProduct();
      _homeStateController.sink
          .add(TopProductLoaded(listProduct: listTopProduct));
    } else if (event is LoadTopSearch) {
      final listTopSearch = await homeRepository.loadTopSearch();
      _homeStateController.sink
          .add(TopSearchLoaded(listTopKeyword: listTopSearch));
    }
  }

  @override
  void dispose() {
    _homeEventController.close();
    _homeStateController.close();
    super.dispose();
  }
}
