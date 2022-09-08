import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/address/data/models/add_update_delete_address.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/address_repository_impl.dart';

class UpdateAddressUseCase {
  final AddressRepositoryImpl addressRepositoryImpl;

  UpdateAddressUseCase({required this.addressRepositoryImpl});

  Future<Either<Failure, AddUpdateDeleteAddressModel>> call(
          {double? latitude,
          double? longitude,
          int? addressID,
          String? name,
          String? city,
          String? region,
          String? details,
          String? notes}) =>
      addressRepositoryImpl.updateAddress(
          addressID: addressID,
          name: name,
          longitude: longitude,
          latitude: latitude,
          details: details,
          city: city,
          notes: notes,
          region: region);
}
