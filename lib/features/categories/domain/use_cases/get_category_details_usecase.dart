import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/categories/data/models/categorise_model.dart';
import 'package:shop_clean_architecture/features/categories/data/models/category_details_model.dart';
import 'package:shop_clean_architecture/features/categories/data/repositories/categories_repository_impl.dart';

import '../../../../core/error/failures.dart';

class GetCategoryDetailsUseCase{
  final CategoriesRepositoryImpl categoriesRepositoryImpl;

  GetCategoryDetailsUseCase({required this.categoriesRepositoryImpl});
  Future<Either<Failure, CategoryDetailsModel>> call({int?categoryID}) async =>
      await categoriesRepositoryImpl.getCategoryDetails(categoryID: categoryID);
}