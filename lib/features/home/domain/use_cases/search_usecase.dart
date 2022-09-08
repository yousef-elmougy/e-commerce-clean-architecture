import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/home/data/models/search_model.dart';
import 'package:shop_clean_architecture/features/home/data/repositories/home_repository_impl.dart';
import 'package:shop_clean_architecture/features/home/domain/repositories/home_repository.dart';

import '../../data/models/home_model.dart';

class SearchUseCase {
  final HomeRepositoryImpl homeRepositoryImpl;

  SearchUseCase({required this.homeRepositoryImpl});

  Future<Either<Failure, SearchModel>> call({String? text}) async =>
      await homeRepositoryImpl.search(text: text);
}
