import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/network/network_info.dart';
import 'package:shop_clean_architecture/features/categories/data/data_sources/categories_local_data_source.dart';
import 'package:shop_clean_architecture/features/categories/data/models/categorise_model.dart';
import 'package:shop_clean_architecture/features/categories/data/models/category_details_model.dart';
import 'package:shop_clean_architecture/features/categories/domain/repositories/categories_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/categories_remote_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final NetworkInfo networkInfo;
  final CategoriesRemoteDataSourceImpl categoriesRemoteDataSourceImpl;
  final CategoriesLocalDataSourceImpl categoriesLocalDataSourceImpl;

  CategoriesRepositoryImpl(
      {required this.networkInfo,
        required this.categoriesRemoteDataSourceImpl,
        required this.categoriesLocalDataSourceImpl});

  @override
  Future<Either<Failure, CategoriesModel>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await categoriesRemoteDataSourceImpl.getCategoriesData();
        categoriesLocalDataSourceImpl.cacheCategoriesData(remoteCategories);
        return Right(remoteCategories);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final cacheCategories = await categoriesLocalDataSourceImpl.getCachedCategoriesData();
        return Right(cacheCategories);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

 @override
  Future<Either<Failure, CategoryDetailsModel>> getCategoryDetails({int ? categoryID}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategoryDetails = await categoriesRemoteDataSourceImpl.getCategoryDetails(categoryID: categoryID);
        categoriesLocalDataSourceImpl.cacheCategoryDetails(remoteCategoryDetails);
        return Right(remoteCategoryDetails);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final cacheCategoryDetails = await categoriesLocalDataSourceImpl.getCachedCategoryDetails();
        return Right(cacheCategoryDetails);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}
