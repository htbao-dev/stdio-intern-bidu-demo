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
