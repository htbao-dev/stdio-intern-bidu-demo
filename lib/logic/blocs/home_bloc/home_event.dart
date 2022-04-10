part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadBannerAndCategory extends HomeEvent {}

class LoadNewestProduct extends HomeEvent {}

class LoadTopProduct extends HomeEvent {}

class LoadTopSearch extends HomeEvent {}
