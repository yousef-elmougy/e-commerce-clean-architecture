import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';

import '../../data/models/categorise_model.dart';
import '../../data/models/category_details_model.dart';

abstract class CategoriesRepository{
  Future<Either<Failure,CategoriesModel>> getCategories();
  Future<Either<Failure,CategoryDetailsModel>> getCategoryDetails({int?categoryID});
}