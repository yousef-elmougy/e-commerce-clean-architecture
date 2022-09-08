import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/cart/data/models/change_cart_model.dart';
import 'package:shop_clean_architecture/features/cart/data/repositories/cart_repository_impl.dart';

import '../../data/models/change_cart_model.dart';
import '../../data/models/update_cart_model.dart';
import '../../data/repositories/cart_repository_impl.dart';


class UpdateCartUseCase {
  final CartRepositoryImpl cartRepositoryImpl;

  UpdateCartUseCase({required this.cartRepositoryImpl});

  Future<Either<Failure, UpdateCartModel>> call({int ?cartID,int ?quantity})=>
      cartRepositoryImpl.updateCart(quantity: quantity,cartID: cartID);
}
