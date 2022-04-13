part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class BannerAndCategoryLoaded extends HomeState {
  final List<SystemBanner> listBanner;
  final List<Category> listCategory;

  const BannerAndCategoryLoaded(
      {required this.listBanner, required this.listCategory});

  @override
  List<Object> get props => [listBanner, listCategory];
}

class NewestProductLoaded extends HomeState {
  final List<Product> listProduct;

  const NewestProductLoaded({required this.listProduct});

  @override
  List<Object> get props => [listProduct];
}

class TopProductLoaded extends HomeState {
  final List<Product> listProduct;

  const TopProductLoaded({required this.listProduct});

  @override
  List<Object> get props => [listProduct];
}

class TopSearchLoaded extends HomeState {
  final List<Keyword> listTopKeyword;

  const TopSearchLoaded({required this.listTopKeyword});

  @override
  List<Object> get props => [listTopKeyword];
}

class SuggestProductLoaded extends HomeState {
  final List<Product> listProduct;

  const SuggestProductLoaded({required this.listProduct});

  @override
  List<Object> get props => [listProduct];
}
