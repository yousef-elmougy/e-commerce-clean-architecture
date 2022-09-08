import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/categories/data/models/categorise_model.dart';
import 'package:shop_clean_architecture/features/categories/data/repositories/categories_repository_impl.dart';

import '../../../../core/error/failures.dart';

class GetCategoriesUseCase{
final CategoriesRepositoryImpl categoriesRepositoryImpl;

  GetCategoriesUseCase({required this.categoriesRepositoryImpl});
Future<Either<Failure, CategoriesModel>> call() async =>
    await categoriesRepositoryImpl.getCategories();
}