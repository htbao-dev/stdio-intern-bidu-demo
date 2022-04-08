import 'dart:async';
import 'package:bidu_demo/data/models/banner.dart';
import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<LoadBannerAndCategory>(loadBannerAndCategory);
    on<LoadNewestProduct>(loadNewestProduct);
  }

  Future loadNewestProduct(event, emit) async {
    final listnewestProduct = await homeRepository.loadNewestProduct();
    emit(NewestProductLoaded(listProduct: listnewestProduct));
  }

  Future loadBannerAndCategory(event, emit) async {
    final bannerAndCategory = await homeRepository.loadBannerAndCategory();
    emit(BannerAndCategoryLoaded(
        listBanner: bannerAndCategory.listBanner,
        listCategory: bannerAndCategory.listCategory));
  }
}
