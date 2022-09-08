import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/network/network_info.dart';
import 'package:shop_clean_architecture/features/home/data/data_sources/home_local_data_source.dart';
import 'package:shop_clean_architecture/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:shop_clean_architecture/features/home/data/models/home_model.dart';
import 'package:shop_clean_architecture/features/home/data/models/search_model.dart';
import 'package:shop_clean_architecture/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSourceImpl homeRemoteDataSourceImpl;
  final HomeLocalDataSourceImpl homeLocalDataSourceImpl;

  HomeRepositoryImpl(
      {required this.networkInfo,
      required this.homeRemoteDataSourceImpl,
      required this.homeLocalDataSourceImpl});

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHome = await homeRemoteDataSourceImpl.getHomeData();
        homeLocalDataSourceImpl.cacheHomeData(remoteHome);
        return Right(remoteHome);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheHome = await homeLocalDataSourceImpl.getCachedHomeData();
        return Right(cacheHome);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, SearchModel>> search({String? text})async {
    if (await networkInfo.isConnected) {
      try {
      final remoteSearch = await homeRemoteDataSourceImpl.search(text: text);
      return Right(remoteSearch);
    } on ServerException {
      return Left(ServerFailure());
    }
    }else{
      return Left(OfflineFailure());
    }
  }
}
