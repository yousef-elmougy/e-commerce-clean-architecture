import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/favorites/data/models/favorites_model.dart';

import '../../data/models/change_favorites_model.dart';

abstract class FavoritesRepository {
  Future<Either<Failure,FavoritesModel>> getFavorites();
  Future<Either<Failure,ChangeFavoritesModel>> changeFavorites({int? productID});
}