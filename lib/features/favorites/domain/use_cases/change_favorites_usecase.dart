import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/favorites/data/models/change_favorites_model.dart';
import 'package:shop_clean_architecture/features/favorites/data/repositories/favorites_repository_impl.dart';


class ChangeFavoritesUseCase {
  final FavoritesRepositoryImpl favoritesRepositoryImpl;

  ChangeFavoritesUseCase({required this.favoritesRepositoryImpl});

  Future<Either<Failure, ChangeFavoritesModel>> call({int ?productID})=>
      favoritesRepositoryImpl.changeFavorites(productID: productID);
}
