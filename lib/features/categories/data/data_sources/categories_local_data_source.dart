import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_architecture/features/categories/data/models/categorise_model.dart';
import 'package:shop_clean_architecture/features/categories/data/models/category_details_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utiles/app_strings.dart';

abstract class CategoriesLocalDataSource {
  Future<void> cacheCategoriesData(CategoriesModel categoriesModel);
  Future<CategoriesModel> getCachedCategoriesData();

  Future<CategoryDetailsModel> getCachedCategoryDetails();
  Future<void> cacheCategoryDetails(CategoryDetailsModel categoryDetailsModel);

}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoriesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCategoriesData(CategoriesModel categoriesModel) =>
      sharedPreferences.setString(
          AppStrings.categoriesKey, json.encode(categoriesModel));

  @override
  Future<CategoriesModel> getCachedCategoriesData() {
    final jsonString = sharedPreferences.getString(AppStrings.categoriesKey);
    if (jsonString != null) {
      final cacheCategories =
          Future.value(CategoriesModel.fromJson(json.decode(jsonString)));
      return cacheCategories;
    } else {
      throw CacheException();
    }
  }
  @override
  Future<void> cacheCategoryDetails(CategoryDetailsModel categoryDetailsModel) =>
      sharedPreferences.setString(
          AppStrings.categoryDetailsKey, json.encode(categoryDetailsModel));

  @override
  Future<CategoryDetailsModel> getCachedCategoryDetails() {
    final jsonString = sharedPreferences.getString(AppStrings.categoryDetailsKey);
    if (jsonString != null) {
      final cacheCategoryDetails =
          Future.value(CategoryDetailsModel.fromJson(json.decode(jsonString)));
      return cacheCategoryDetails;
    } else {
      throw CacheException();
    }
  }

}
