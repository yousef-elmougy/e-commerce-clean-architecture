import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utiles/app_strings.dart';
import '../models/address_model.dart';

abstract class AddressLocalDataSource {
  Future<void> cacheAddress(AddressModel addressModel);

  Future<AddressModel> getCachedAddress();
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  final SharedPreferences sharedPreferences;

  AddressLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAddress(AddressModel addressModel) =>
      sharedPreferences.setString(AppStrings.addressKey, json.encode(addressModel));

  @override
  Future<AddressModel> getCachedAddress() {
    final jsonString = sharedPreferences.getString(AppStrings.addressKey);
    return  jsonString != null
        ? Future.value(AddressModel.fromJson(json.decode(jsonString)))
        : throw CacheException();
  }
}
