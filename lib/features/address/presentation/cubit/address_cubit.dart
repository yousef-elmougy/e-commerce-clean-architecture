import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/features/address/data/models/address_model.dart';
import 'package:shop_clean_architecture/features/address/domain/use_cases/add_address_usecase.dart';
import 'package:shop_clean_architecture/features/address/domain/use_cases/delete_address_usecase.dart';
import 'package:shop_clean_architecture/features/address/domain/use_cases/get_address_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/add_update_delete_address.dart';
import '../../domain/use_cases/update_address_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(
      {required this.getAddressUseCase,
      required this.addAddressUseCase,
      required this.updateAddressUseCase,
      required this.deleteAddressUseCase})
      : super(AddressInitial());

  final TextEditingController addressCityController = TextEditingController();
  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController addressRegionController = TextEditingController();
  final TextEditingController addressDetailsController =
      TextEditingController();
  final TextEditingController addressNotesController = TextEditingController();

  final addressFormKey = GlobalKey<FormState>();

  /// GET ADDRESS

  final GetAddressUseCase getAddressUseCase;
  AddressModel? addressModel;

  Future<void> getAddress() async {
    emit(GetAddressLoading());
    await getAddressUseCase().then((value) => value.fold(
            (failure) =>
                emit(GetAddressError(AppConstants.mapFailureToMsg(failure))),
            (value) {
          addressModel = value;
          emit(GetAddressLoaded(value));
        }));
  }

  /// ADD ADDRESS
  final AddAddressUseCase addAddressUseCase;
  AddUpdateDeleteAddressModel? addUpdateDeleteAddressModel;

  Future<void> addAddress() async {
    await _addUpdateDeleteAddress(
        addUpdateDelete: addAddressUseCase(
            name: addressNameController.text.trim(),
            longitude: 31.3260088,
            latitude: 30.0616863,
            details: addressDetailsController.text.trim(),
            city: addressCityController.text.trim(),
            notes: addressNotesController.text.trim(),
            region: addressRegionController.text.trim()));
  }

  /// UPDATE ADDRESS
  final UpdateAddressUseCase updateAddressUseCase;

  Future<void> updateAddress({int? addressID}) async {
    emit(AddUpdateDeleteAddressLoading());
    await _addUpdateDeleteAddress(
        addUpdateDelete: updateAddressUseCase(
            addressID: addressID,
            name: addressNameController.text.trim(),
            longitude: 31.3260088,
            latitude: 30.0616863,
            details: addressDetailsController.text.trim(),
            city: addressCityController.text.trim(),
            notes: addressNotesController.text.trim(),
            region: addressRegionController.text.trim()));
  }

  /// DELETE ADDRESS

  final DeleteAddressUseCase deleteAddressUseCase;

  Future<void> deleteAddress({int? addressID}) async {
    emit(AddUpdateDeleteAddressLoading());
    await _addUpdateDeleteAddress(
        addUpdateDelete: deleteAddressUseCase(addressID: addressID));
  }

  ///

  Future<void> _addUpdateDeleteAddress(
      {Future<Either<Failure, AddUpdateDeleteAddressModel>>?
          addUpdateDelete}) async {
    final addUpdateDeleteAddress = await addUpdateDelete;
    addUpdateDeleteAddress?.fold(
        (failure) => emit(
            AddUpdateDeleteAddressError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      addUpdateDeleteAddressModel = value;
      getAddress();
      emit(AddUpdateDeleteAddressLoaded(value));
    });
  }
}
