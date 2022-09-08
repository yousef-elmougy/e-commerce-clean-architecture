import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/cart/data/models/cart_model.dart';
import 'package:shop_clean_architecture/features/cart/data/repositories/cart_repository_impl.dart';

import '../../data/models/cart_model.dart';
import '../../data/repositories/cart_repository_impl.dart';

class GetCartUseCase {
  final CartRepositoryImpl cartRepositoryImpl;

  GetCartUseCase({required this.cartRepositoryImpl});

  Future<Either<Failure, CartModel>> call() =>
      cartRepositoryImpl.getCart();
}
