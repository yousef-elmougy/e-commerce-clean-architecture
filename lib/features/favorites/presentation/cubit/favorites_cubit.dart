import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/features/favorites/domain/use_cases/get_favorites_usecase.dart';
import 'package:shop_clean_architecture/features/home/presentation/cubit/home_cubit.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utiles/app_strings.dart';
import '../../data/models/change_favorites_model.dart';
import '../../data/models/favorites_model.dart';
import '../../domain/use_cases/change_favorites_usecase.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(
      {required this.getFavoritesUseCase, required this.changeFavoritesUseCase})
      : super(FavoritesInitial());

  /// GET FAVORITES
  final GetFavoritesUseCase getFavoritesUseCase;

  FavoritesModel? favoritesModel;

  Future<void> getFavorites() async {
    emit(GetFavoritesLoading());
    final favorites = await getFavoritesUseCase();
    favorites
        .fold((failure) => emit(GetFavoritesError(AppConstants.mapFailureToMsg(failure))),
            (value) {
      favoritesModel = value;
      emit(GetFavoritesLoaded(value));
    });
  }

  /// CHANGE FAVORITES
  final ChangeFavoritesUseCase changeFavoritesUseCase;
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFav(context, int? productID) {
    BlocProvider.of<HomeCubit>(context).favorites[productID] =
        !(BlocProvider.of<HomeCubit>(context).favorites[productID]);
  }

  Future<void> changeFavorites(context, {int? productID}) async {
    changeFav(context, productID);
    emit(ChangeFavoritesLoading());
    final changeFavorites = await changeFavoritesUseCase(productID: productID);
    changeFavorites.fold((failure) {
      changeFav(context, productID);
      emit(ChangeFavoritesError(AppConstants.mapFailureToMsg(failure)));
    }, (value) {
      changeFavoritesModel?.status == false
          ? changeFav(context, productID)
          : getFavorites();
      emit(ChangeFavoritesLoaded(value));
    });
  }

}
