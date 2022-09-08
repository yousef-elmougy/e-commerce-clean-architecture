import 'package:shop_clean_architecture/features/user/data/data_sources/remote_date_source/remote_user_data_source.dart';
import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/dio_consumer.dart';
import '../../../../../core/api/end_points.dart';
import '../../models/change_password_model.dart';
import '../../models/user_model.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final DioConsumer dioConsumer;

  RemoteUserDataSourceImpl({required this.dioConsumer});

  /// LOGIN
  @override
  Future<UserModel> userLogin(
      {required String email, required String password}) async => await dioConsumer.post(ApiEndPoints.login, queryParameters: {
      'email': email,
      'password': password,
    }).then((value) => UserModel.fromJson(value));

  /// REGISTER
  @override
  Future<UserModel> userRegister(
      {required String email,
        required String password,
        required String name,
        required String phone}) async =>
      await dioConsumer.post(ApiEndPoints.register, queryParameters: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      }).then((value) => UserModel.fromJson(value));

  /// CHANGE PASSWORD
  @override
  Future<ChangePasswordModel> userChangePassword(
      {required String currentPassword,
        required String newPassword}) async =>
      await dioConsumer.post(ApiEndPoints.changePassword, queryParameters: {
        'current_password': currentPassword,
        'new_password': newPassword,
      }).then((value) => ChangePasswordModel.fromJson(value));

  /// GET PROFILE
  @override
  Future<UserModel> userProfile() async => await dioConsumer
      .get(ApiEndPoints.profile)
      .then((value) => UserModel.fromJson(value));

  /// UPDATE PROFILE
  @override
  Future<UserModel> updateUserProfile({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async =>
      await dioConsumer.put(ApiEndPoints.updateProfile, queryParameters: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      }).then((value) => UserModel.fromJson(value));

  /// LOG OUT

  @override
  Future<UserModel> userLogOut() async => await dioConsumer
      .post(ApiEndPoints.logout)
      .then((value) => UserModel.fromJson(value));
}
