import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utiles/app_strings.dart';
import '../models/favorites_model.dart';

abstract class FavoritesLocalDataSource{
  Future<void> cacheFavorites(FavoritesModel favoritesModel);
  Future<FavoritesModel> getCachedFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheFavorites(FavoritesModel favoritesModel) =>
      sharedPreferences.setString(
          AppStrings.favoritesKey, json.encode(favoritesModel));

  @override
  Future<FavoritesModel> getCachedFavorites() {
    final jsonString = sharedPreferences.getString(AppStrings.favoritesKey);
    if (jsonString != null) {
      final cacheFavorites =
      Future.value(FavoritesModel.fromJson(json.decode(jsonString)));
      return cacheFavorites;
    } else {
      throw CacheException();
    }
  }

}
