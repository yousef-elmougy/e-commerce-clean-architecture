import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/features/address/data/models/address_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/address_repository_impl.dart';

class GetAddressUseCase {
  final AddressRepositoryImpl addressRepositoryImpl;

  GetAddressUseCase({required this.addressRepositoryImpl});

  Future<Either<Failure, AddressModel>> call() =>
      addressRepositoryImpl.getAddress();
}
