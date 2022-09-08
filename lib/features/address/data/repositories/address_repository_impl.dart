import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/network/network_info.dart';
import 'package:shop_clean_architecture/features/address/data/models/add_update_delete_address.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/address_repository.dart';
import '../data_sources/address_remote_data_source.dart';
import '../data_sources/adress_local_data_source.dart';
import '../models/address_model.dart';

class AddressRepositoryImpl implements AddressRepository {
  final NetworkInfo networkInfo;
  final AddressRemoteDataSourceImpl addressRemoteDataSourceImpl;
  final AddressLocalDataSourceImpl addressLocalDataSourceImpl;

  AddressRepositoryImpl(
      {required this.networkInfo,
      required this.addressRemoteDataSourceImpl,
      required this.addressLocalDataSourceImpl});

  /// GET ADDRESS

  @override
  Future<Either<Failure, AddressModel>> getAddress() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAddress = await addressRemoteDataSourceImpl.getAddress();
        addressLocalDataSourceImpl.cacheAddress(remoteAddress);
        return Right(remoteAddress);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheAddress =
            await addressLocalDataSourceImpl.getCachedAddress();
        return Right(cacheAddress);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  /// ADD ADDRESS

  @override
  Future<Either<Failure, AddUpdateDeleteAddressModel>> addAddress(
          {double? latitude,
          double? longitude,
          String? name,
          String? city,
          String? region,
          String? details,
          String? notes}) async =>
      await _addUpdateDeleteAddress(
        addUpdateDeleteAddressModel: addressRemoteDataSourceImpl.addAddress(
            name: name,
            longitude: longitude,
            latitude: latitude,
            details: details,
            city: city,
            notes: notes,
            region: region),
      );

  /// UPDATE ADDRESS

  @override
  Future<Either<Failure, AddUpdateDeleteAddressModel>> updateAddress(
          {int? addressID,
          double? latitude,
          double? longitude,
          String? name,
          String? city,
          String? region,
          String? details,
          String? notes}) async =>
      await _addUpdateDeleteAddress(
        addUpdateDeleteAddressModel: addressRemoteDataSourceImpl.updateAddress(
            addressID: addressID,
            name: name,
            longitude: longitude,
            latitude: latitude,
            details: details,
            city: city,
            notes: notes,
            region: region),
      );

  /// DELETE ADDRESS

  @override
  Future<Either<Failure, AddUpdateDeleteAddressModel>> deleteAddress(
          {int? addressID}) async =>
      await _addUpdateDeleteAddress(
          addUpdateDeleteAddressModel:
              addressRemoteDataSourceImpl.deleteAddress(addressID: addressID));

  ///

  Future<Either<Failure, AddUpdateDeleteAddressModel>> _addUpdateDeleteAddress(
      {Future<AddUpdateDeleteAddressModel>?
          addUpdateDeleteAddressModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final addDeleteUpdate = await addUpdateDeleteAddressModel;
        return Right(addDeleteUpdate!);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
