import 'package:shop_clean_architecture/core/api/end_points.dart';
import 'package:shop_clean_architecture/features/home/data/models/search_model.dart';

import '../../../../core/api/dio_consumer.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeData();
  Future<SearchModel> search({String?text});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioConsumer dioConsumer;

  HomeRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<HomeModel> getHomeData() async =>
      await dioConsumer
          .get(ApiEndPoints.home)
          .then((value) => HomeModel.fromJson(value));

  @override
  Future<SearchModel> search({String?text})async =>
      await dioConsumer
          .post(ApiEndPoints.search,queryParameters: {'text':text})
          .then((value) => SearchModel.fromJson(value));

}
