

import 'package:equatable/equatable.dart';

import '../../../data/models/change_password_model.dart';
import '../../../data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();
 @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}


class UserLoading extends UserState{}
class UserLoaded extends UserState{
  final UserModel userModel;

   const UserLoaded(this.userModel);
  @override
  List<Object?> get props => [userModel];
}
class UserError extends UserState{
  final String error;
 const UserError(this.error);
  @override
  List<Object?> get props => [error];

}
class ChangePasswordLoading extends UserState{}
class ChangePasswordLoaded extends UserState{
  final ChangePasswordModel changePasswordModel;

   const ChangePasswordLoaded(this.changePasswordModel);
}
class ChangePasswordError extends UserState{
  final String error;
 const ChangePasswordError(this.error);

}


