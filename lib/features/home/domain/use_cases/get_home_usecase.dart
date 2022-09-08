import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/home/data/repositories/home_repository_impl.dart';
import 'package:shop_clean_architecture/features/home/domain/repositories/home_repository.dart';

import '../../data/models/home_model.dart';

class GetHomeDataUseCase {
  final HomeRepositoryImpl homeRepositoryImpl;

  GetHomeDataUseCase({required this.homeRepositoryImpl});

  Future<Either<Failure, HomeModel>> call() async =>
      await homeRepositoryImpl.getHomeData();
}
