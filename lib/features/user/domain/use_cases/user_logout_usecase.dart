import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/user/data/repositories/user_repository_impl.dart';
import 'package:shop_clean_architecture/features/user/domain/repositories/user_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';

class UserLogOutUseCase {
  final UserRepositoryImpl userRepositoryImpl;

  UserLogOutUseCase({required this.userRepositoryImpl});

  Future<Either<Failure, UserModel>> call() async =>
      await userRepositoryImpl.userLogOut();
}
