import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/features/user/data/data_sources/local_data_source/user_local_data_source.dart';
import 'package:shop_clean_architecture/features/user/data/models/change_password_model.dart';
import 'package:shop_clean_architecture/features/user/data/models/user_model.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_change_password_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_login_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_logout_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_profile_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_register_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_update_profile_usecase.dart';
import 'package:shop_clean_architecture/features/user/presentation/cubit/user/user_state.dart';
import '../../../../../config/routes/routes.dart';
import 'package:shop_clean_architecture/injection_container.dart' as di;

class UserCubit extends Cubit<UserState> {
  UserCubit(
      {required this.localUserDataSourceImpl,
      required this.userProfileUseCase,
      required this.updateProfileUseCase,
      required this.userLogOutUseCase,
      required this.userRegisterUseCase,
      required this.userChangePasswordUseCase,
      required this.userLoginUseCase})
      : super(UserInitial());
  final LocalUserDataSourceImpl localUserDataSourceImpl;

  UserModel? userModel;

  /// LOGIN
  final UserLoginUseCase userLoginUseCase;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    emit(UserLoading());
    final login = await userLoginUseCase(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text.trim());
    login.fold(
        (failure) => emit(UserError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      if (value.status == true) {
        localUserDataSourceImpl.cacheToken("${value.data?.token.toString()}");
      }
      emit(UserLoaded(value));
    });
  }

  /// REGISTER
  final UserRegisterUseCase userRegisterUseCase;
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  Future<void> register() async {
    emit(UserLoading());
    final register = await userRegisterUseCase(
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text.trim(),
        name: registerNameController.text.trim(),
        phone: registerPhoneController.text.trim());
    register.fold(
        (failure) => emit(UserError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      if (value.status == true) {
        localUserDataSourceImpl.cacheToken("${value.data?.token.toString()}");
      }
      emit(UserLoaded(value));
    });
  }

  /// CHANGE PASSWORD
  final UserChangePasswordUseCase userChangePasswordUseCase;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final changePasswordFormKey = GlobalKey<FormState>();
  ChangePasswordModel ?changePasswordModel;
  Future<void> changePassword(context) async {
    emit(ChangePasswordLoading());
    final changePassword = await userChangePasswordUseCase(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim());
    changePassword.fold(
        (failure) => emit(ChangePasswordError(AppConstants.mapFailureToMsg(failure))),
        (value) {
          changePasswordModel = value;
          getProfile();
          if (changePasswordModel?.status == true) {
            AppConstants.showToast(
                msg: '${changePasswordModel?.message}');
            context.back();
          }else{
            AppConstants.showToast(
                msg: '${changePasswordModel?.message}');
          }
          emit(ChangePasswordLoaded(value));
        });
  }

  /// GET PROFILE

  final UserProfileUseCase userProfileUseCase;

  Future<void> getProfile() async {
    emit(UserLoading());
    final profile = await userProfileUseCase();
    profile.fold(
        (failure) => emit(UserError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      userModel = value;
      emit(UserLoaded(value));
    });
  }

  /// UPDATE PROFILE
  final UserUpdateProfileUseCase updateProfileUseCase;
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updatePasswordController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updatePhoneController = TextEditingController();
  final updateProfileFormKey = GlobalKey<FormState>();

  Future<void> updateProfile() async {
    emit(UserLoading());
    final updateProfile = await updateProfileUseCase(
        email: updateEmailController.text.trim(),
        password: updatePasswordController.text.trim(),
        name: updateNameController.text.trim(),
        phone: updatePhoneController.text.trim());
    updateProfile.fold(
        (failure) => emit(UserError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      getProfile();
      emit(UserLoaded(value));
    });
  }

  /// LOG OUT
  final UserLogOutUseCase userLogOutUseCase;

  Future<void> logOut(context) async {
    emit(UserLoading());
    final logOut = await userLogOutUseCase();
    logOut.fold(
        (failure) => emit(UserError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      localUserDataSourceImpl.clearCachedUser();
      localUserDataSourceImpl.clearToken();
      Navigator.pushReplacementNamed(context, Routes.loginScreen);
      emit(UserLoaded(value));
    });
  }
}
