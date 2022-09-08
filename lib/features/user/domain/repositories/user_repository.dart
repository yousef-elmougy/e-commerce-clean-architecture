import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/change_password_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> userLogin(
      {required String email, required String password});

  Future<Either<Failure, ChangePasswordModel>> userChangePassword(
      {required String currentPassword, required String newPassword});

  Future<Either<Failure, UserModel>> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
 Future<Either<Failure, UserModel>> updateUserProfile({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
  Future<Either<Failure, UserModel>> userLogOut();
  Future<Either<Failure, UserModel>> userProfile();
}
