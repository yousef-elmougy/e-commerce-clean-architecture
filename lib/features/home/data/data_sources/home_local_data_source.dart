import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_architecture/features/home/data/models/home_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utiles/app_strings.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheHomeData(HomeModel homeModel);

  Future<HomeModel> getCachedHomeData();

}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheHomeData(HomeModel homeModel) =>
      sharedPreferences.setString(AppStrings.homeKey, json.encode(homeModel));

  @override
  Future<HomeModel> getCachedHomeData() {
    final jsonString = sharedPreferences.getString(AppStrings.homeKey);
    if (jsonString != null) {
      final cacheHome =
          Future.value(HomeModel.fromJson(json.decode(jsonString)));
      return cacheHome;
    } else {
      throw CacheException();
    }
  }


}
