import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/network/network_info.dart';
import 'package:shop_clean_architecture/features/favorites/data/models/change_favorites_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../data_sources/favorites_local_data_source.dart';
import '../data_sources/favorites_remote_data_source.dart';
import '../models/favorites_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final NetworkInfo networkInfo;
  final FavoritesRemoteDataSourceImpl favoritesRemoteDataSourceImpl;
  final FavoritesLocalDataSourceImpl favoritesLocalDataSourceImpl;

  FavoritesRepositoryImpl(
      {required this.networkInfo,
      required this.favoritesRemoteDataSourceImpl,
      required this.favoritesLocalDataSourceImpl});

  @override
  Future<Either<Failure, FavoritesModel>> getFavorites() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFavorites =
            await favoritesRemoteDataSourceImpl.getFavorites();
        favoritesLocalDataSourceImpl.cacheFavorites(remoteFavorites);
        return Right(remoteFavorites);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheFavorites =
            await favoritesLocalDataSourceImpl.getCachedFavorites();
        return Right(cacheFavorites);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ChangeFavoritesModel>> changeFavorites(
      {int? productID}) async {
    if (await networkInfo.isConnected) {
      try {
      final changeFavorites = await favoritesRemoteDataSourceImpl
          .changeFavorites(productID: productID);
      return Right(changeFavorites);
    } on ServerException {
      return Left(ServerFailure());
    }
    }else{
      return Left(OfflineFailure());
    }
  }


}
