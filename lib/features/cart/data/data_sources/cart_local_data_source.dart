import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utiles/app_strings.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<void> cacheCart(CartModel cartModel);

  Future<CartModel> getCachedCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCart(CartModel cartModel) =>
      sharedPreferences.setString(AppStrings.cartKey, json.encode(cartModel));

  @override
  Future<CartModel> getCachedCart() {
    final jsonString = sharedPreferences.getString(AppStrings.cartKey);
  return  jsonString != null
        ? Future.value(CartModel.fromJson(json.decode(jsonString)))
        : throw CacheException();
  }
}
