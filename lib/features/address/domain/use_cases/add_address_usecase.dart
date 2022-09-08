import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/address/data/models/add_update_delete_address.dart';
import 'package:shop_clean_architecture/features/address/data/models/address_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/address_repository_impl.dart';

class AddAddressUseCase {
  final AddressRepositoryImpl addressRepositoryImpl;

  AddAddressUseCase({required this.addressRepositoryImpl});

  Future<Either<Failure, AddUpdateDeleteAddressModel>> call(
          {double? latitude,
          double? longitude,
          String? name,
          String? city,
          String? region,
          String? details,
          String? notes}) =>
      addressRepositoryImpl.addAddress(
          name: name,
          longitude: longitude,
          latitude: latitude,
          details: details,
          city: city,
          notes: notes,
          region: region);
}
