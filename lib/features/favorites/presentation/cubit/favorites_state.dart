part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

/// GET FAVORITES

class GetFavoritesLoading extends FavoritesState {}

class GetFavoritesLoaded extends FavoritesState {
  final FavoritesModel favoritesModel;

  GetFavoritesLoaded(this.favoritesModel);
}

class GetFavoritesError extends FavoritesState {
  final String error;

  GetFavoritesError(this.error);
}

/// CHANGE FAVORITES

class ChangeFavoritesLoading extends FavoritesState {}

class ChangeFavoritesLoaded extends FavoritesState {
  final ChangeFavoritesModel changeFavoritesModel;

  ChangeFavoritesLoaded(this.changeFavoritesModel);
}

class ChangeFavoritesError extends FavoritesState {
  final String error;

  ChangeFavoritesError(this.error);
}
