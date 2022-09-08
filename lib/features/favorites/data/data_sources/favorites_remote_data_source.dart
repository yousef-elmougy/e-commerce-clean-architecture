import 'package:shop_clean_architecture/core/api/dio_consumer.dart';
import 'package:shop_clean_architecture/core/api/end_points.dart';
import 'package:shop_clean_architecture/features/favorites/data/models/change_favorites_model.dart';
import 'package:shop_clean_architecture/features/favorites/data/models/favorites_model.dart';


abstract class FavoritesRemoteDataSource {
  Future<FavoritesModel> getFavorites();
  Future<ChangeFavoritesModel> changeFavorites({int? productID});
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final DioConsumer dioConsumer;

  FavoritesRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<FavoritesModel> getFavorites() async => await dioConsumer
      .get(ApiEndPoints.favorites)
      .then((value) => FavoritesModel.fromJson(value));

  @override
  Future<ChangeFavoritesModel> changeFavorites({int? productID}) async => await dioConsumer
      .post(ApiEndPoints.favorites,queryParameters: {'product_id':productID})
      .then((value) => ChangeFavoritesModel.fromJson(value));


}
