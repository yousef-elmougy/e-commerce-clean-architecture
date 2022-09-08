import '../../models/change_password_model.dart';
import '../../models/user_model.dart';

abstract class RemoteUserDataSource {
  Future<UserModel> userLogin(
      {required String email, required String password});

  Future<ChangePasswordModel> userChangePassword(
      {required String currentPassword, required String newPassword});

  Future<UserModel> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  Future<UserModel> updateUserProfile({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  Future<UserModel> userLogOut();

  Future<UserModel> userProfile();
}
