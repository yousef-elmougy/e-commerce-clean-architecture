import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/favorites/data/models/favorites_model.dart';
import 'package:shop_clean_architecture/features/favorites/data/repositories/favorites_repository_impl.dart';

class GetFavoritesUseCase {
  final FavoritesRepositoryImpl favoritesRepositoryImpl;

  GetFavoritesUseCase({required this.favoritesRepositoryImpl});

  Future<Either<Failure, FavoritesModel>> call() =>
      favoritesRepositoryImpl.getFavorites();
}
