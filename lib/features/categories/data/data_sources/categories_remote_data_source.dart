import 'package:shop_clean_architecture/core/api/dio_consumer.dart';
import 'package:shop_clean_architecture/core/api/end_points.dart';

import '../models/categorise_model.dart';
import '../models/category_details_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoriesModel> getCategoriesData();
  Future<CategoryDetailsModel> getCategoryDetails({int?categoryID});
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final DioConsumer dioConsumer;

  CategoriesRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<CategoriesModel> getCategoriesData() async => await dioConsumer
      .get(ApiEndPoints.categories)
      .then((value) => CategoriesModel.fromJson(value));

  @override
  Future<CategoryDetailsModel> getCategoryDetails({int? categoryID}) async => await dioConsumer
      .get('${ApiEndPoints.categoryDetails}/$categoryID')
      .then((value) => CategoryDetailsModel.fromJson(value));

}
