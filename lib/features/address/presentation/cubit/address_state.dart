part of 'address_cubit.dart';

@immutable
abstract class AddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// GET ADDRESS

class AddressInitial extends AddressState {}

class GetAddressLoading extends AddressState {}

class GetAddressLoaded extends AddressState {
  final AddressModel addressModel;

  GetAddressLoaded(this.addressModel);
}

class GetAddressError extends AddressState {
  final String error;

  GetAddressError(this.error);
}

/// ADD UPDATE DELETE ADDRESS

class AddUpdateDeleteAddressLoading extends AddressState {}

class AddUpdateDeleteAddressLoaded extends AddressState {
  final AddUpdateDeleteAddressModel addUpdateDeleteAddressModel;

  AddUpdateDeleteAddressLoaded(this.addUpdateDeleteAddressModel);

  @override
  List<Object?> get props => [addUpdateDeleteAddressModel];
}

class AddUpdateDeleteAddressError extends AddressState {
  final String error;

  AddUpdateDeleteAddressError(this.error);

  @override
  List<Object?> get props => [error];
}
