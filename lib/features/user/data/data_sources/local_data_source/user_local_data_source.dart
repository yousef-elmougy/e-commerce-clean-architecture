import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_architecture/core/utiles/app_strings.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getCachedUser();

  Future<String> getCachedToken();

  Future<bool> cacheUser(UserModel userToCache);

  Future<bool> cacheToken(String authToken);

  Future<bool> clearCachedUser();

  Future<bool> clearToken();
}

class LocalUserDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalUserDataSourceImpl({required this.sharedPreferences});

  /// GET SAVED DATA

  @override
  Future<UserModel> getCachedUser() {
    final jsonString = sharedPreferences.getString(AppStrings.userKey);
    return jsonString != null
        ? Future.value(UserModel.fromJson(json.decode(jsonString)))
        : throw CacheException();
  }

  @override
  Future<String> getCachedToken() {
    final authToken = sharedPreferences.getString(AppStrings.tokenKey);
    return authToken != null ? Future.value(authToken) : throw CacheException();
  }

  /// SAVE DATA
  @override
  Future<bool> cacheUser(UserModel userToCache) => sharedPreferences.setString(
      AppStrings.userKey, json.encode(userToCache.toJson()));

  @override
  Future<bool> cacheToken(String tokenToCache) async =>
      await sharedPreferences.setString(AppStrings.tokenKey, tokenToCache);

  /// CLEAR DATA
  @override
  Future<bool> clearCachedUser() =>
      sharedPreferences.remove(AppStrings.userKey);

  @override
  Future<bool> clearToken() => sharedPreferences.remove(AppStrings.tokenKey);
}
