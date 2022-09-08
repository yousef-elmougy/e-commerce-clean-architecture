import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';

import '../../data/models/add_update_delete_address.dart';
import '../../data/models/address_model.dart';

abstract class AddressRepository {
  Future<Either<Failure, AddressModel>> getAddress();

    Future<Either<Failure, AddUpdateDeleteAddressModel>> addAddress({
    double? latitude,
    double? longitude,
    String? name,
    String? city,
    String? region,
    String? details,
    String? notes,
  });

    Future<Either<Failure, AddUpdateDeleteAddressModel>> updateAddress({
    int? addressID,
    double? latitude,
    double? longitude,
    String? name,
    String? city,
    String? region,
    String? details,
    String? notes,
  });

    Future<Either<Failure, AddUpdateDeleteAddressModel>> deleteAddress({int? addressID});
}
