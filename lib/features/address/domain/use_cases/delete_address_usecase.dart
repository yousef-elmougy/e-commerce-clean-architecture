import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/address/data/models/add_update_delete_address.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/address_repository_impl.dart';

class DeleteAddressUseCase {
  final AddressRepositoryImpl addressRepositoryImpl;

  DeleteAddressUseCase({required this.addressRepositoryImpl});

  Future<Either<Failure, AddUpdateDeleteAddressModel>> call({int? addressID}) =>
      addressRepositoryImpl.deleteAddress(addressID: addressID);
}
