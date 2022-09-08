import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/error/failures.dart';
import 'package:shop_clean_architecture/features/cart/data/models/cart_model.dart';
import 'package:shop_clean_architecture/features/cart/data/models/change_cart_model.dart';
import 'package:shop_clean_architecture/features/cart/data/models/update_cart_model.dart';

abstract class CartRepository{
Future<Either<Failure,CartModel>> getCart();
Future<Either<Failure,ChangeCartModel>> changeCart({int? productID});
Future<Either<Failure,UpdateCartModel>> updateCart({int? cartID,int? quantity});
}