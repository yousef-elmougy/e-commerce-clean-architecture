import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/user/data/repositories/user_repository_impl.dart';
import 'package:shop_clean_architecture/features/user/domain/repositories/user_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';

class UserLoginUseCase{
  final UserRepositoryImpl userRepositoryImpl;

  UserLoginUseCase({required this.userRepositoryImpl});

  Future<Either<Failure, UserModel>> call({required String email, required String password})async=> await userRepositoryImpl.userLogin(email: email, password: password);
}