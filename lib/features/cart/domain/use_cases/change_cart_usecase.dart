import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/cart/data/models/change_cart_model.dart';
import 'package:shop_clean_architecture/features/cart/data/repositories/cart_repository_impl.dart';

import '../../data/models/change_cart_model.dart';
import '../../data/repositories/cart_repository_impl.dart';


class ChangeCartUseCase {
  final CartRepositoryImpl cartRepositoryImpl;

  ChangeCartUseCase({required this.cartRepositoryImpl});

  Future<Either<Failure, ChangeCartModel>> call({int ?productID})=>
      cartRepositoryImpl.changeCart(productID: productID);
}
