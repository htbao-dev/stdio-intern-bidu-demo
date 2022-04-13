part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadSuggestProduct extends HomeEvent {}

class InitLoad extends HomeEvent {}

class Refresh extends HomeEvent {}
