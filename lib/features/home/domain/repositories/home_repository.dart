import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/home/data/models/home_model.dart';
import 'package:shop_clean_architecture/features/home/data/models/search_model.dart';

abstract class HomeRepository{
  Future<Either<Failure,HomeModel>> getHomeData();
  Future<Either<Failure,SearchModel>> search({String?text});
}