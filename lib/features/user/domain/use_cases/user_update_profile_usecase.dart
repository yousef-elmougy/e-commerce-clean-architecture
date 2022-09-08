import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/user/data/repositories/user_repository_impl.dart';
import 'package:shop_clean_architecture/features/user/domain/repositories/user_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';

class UserUpdateProfileUseCase {
  final UserRepositoryImpl userRepositoryImpl;

  UserUpdateProfileUseCase({required this.userRepositoryImpl});

  Future<Either<Failure, UserModel>> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async =>
      await userRepositoryImpl.updateUserProfile(
          email: email, password: password, name: name, phone: phone);
}
