import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/exceptions.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/user/data/data_sources/remote_date_source/remote_user_data_source_impl.dart';
import 'package:shop_clean_architecture/features/user/data/models/user_model.dart';
import 'package:shop_clean_architecture/features/user/domain/repositories/user_repository.dart';

import '../../../../core/network/network_info.dart';
import '../data_sources/local_data_source/user_local_data_source.dart';
import '../models/change_password_model.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
      {required this.localUserDataSourceImpl,
      required this.networkInfo,
      required this.remoteUserDataSourceImpl});

  final RemoteUserDataSourceImpl remoteUserDataSourceImpl;
  final LocalUserDataSourceImpl localUserDataSourceImpl;
  final NetworkInfo networkInfo;

  /// LOGIN
  @override
  Future<Either<Failure, UserModel>> userLogin(
          {required String email, required String password}) async =>
      _userRepo(
          remoteUserDataSourceImpl.userLogin(email: email, password: password));

  /// REGISTER
  @override
  Future<Either<Failure, UserModel>> userRegister(
          {required String email,
          required String password,
          required String name,
          required String phone}) async =>
      _userRepo(remoteUserDataSourceImpl.userRegister(
          email: email, password: password, name: name, phone: phone));

  /// CHANGE PASSWORD
  @override
  Future<Either<Failure, ChangePasswordModel>> userChangePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      return Right(await remoteUserDataSourceImpl.userChangePassword(
          currentPassword: currentPassword, newPassword: newPassword));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /// GET PROFILE

  @override
  Future<Either<Failure, UserModel>> userProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUserProfile = await remoteUserDataSourceImpl.userProfile();
        localUserDataSourceImpl.cacheUser(remoteUserProfile);
        return Right(remoteUserProfile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheUserProfile = await localUserDataSourceImpl.getCachedUser();
        return Right(cacheUserProfile);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  /// UPDATE PROFILE
  @override
  // try {
  //   return Right(await remoteUserDataSourceImpl.updateUserProfile(
  //       email: email, password: password, name: name, phone: phone));
  // } on ServerException {
  //   return Left(ServerFailure());
  // }
  Future<Either<Failure, UserModel>> updateUserProfile(
          {required String email,
          required String password,
          required String name,
          required String phone}) async =>
      _userRepo(remoteUserDataSourceImpl.updateUserProfile(
          email: email, password: password, name: name, phone: phone));

  /// LOG OUT

  @override
  // try {
  //   return Right(await remoteUserDataSourceImpl.userLogOut());
  // } on ServerException {
  //   return Left(ServerFailure());
  // }
  Future<Either<Failure, UserModel>> userLogOut() async =>
      _userRepo(remoteUserDataSourceImpl.userLogOut());

  ///
  Future<Either<Failure, UserModel>> _userRepo(
      Future<UserModel> function) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await function);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
