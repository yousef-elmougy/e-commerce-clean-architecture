import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/user/data/repositories/user_repository_impl.dart';
import 'package:shop_clean_architecture/features/user/domain/repositories/user_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/change_password_model.dart';
import '../../data/models/user_model.dart';

class UserChangePasswordUseCase {
  final UserRepositoryImpl userRepositoryImpl;

  UserChangePasswordUseCase({required this.userRepositoryImpl});

  Future<Either<Failure, ChangePasswordModel>> call(
          {required String currentPassword,
          required String newPassword}) async =>
      await userRepositoryImpl.userChangePassword(
          currentPassword: currentPassword, newPassword: newPassword);
}
