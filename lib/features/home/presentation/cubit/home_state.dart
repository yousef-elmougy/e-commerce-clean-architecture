part of 'home_cubit.dart';

abstract class HomeState  {}

class HomeInitial extends HomeState {}

class GetHomeDataLoading extends HomeState{}
class GetHomeDataLoaded extends HomeState{
  final HomeModel homeModel;

  GetHomeDataLoaded(this.homeModel);
}
class GetHomeDataError extends HomeState{
  final String error;

  GetHomeDataError(this.error);
}

class SearchLoading extends HomeState{}
class SearchLoaded extends HomeState{
  final SearchModel search;

  SearchLoaded(this.search);
}
class SearchError extends HomeState{
  final String error;

  SearchError(this.error);
}

