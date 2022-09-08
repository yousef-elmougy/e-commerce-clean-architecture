import 'package:shop_clean_architecture/core/api/dio_consumer.dart';
import 'package:shop_clean_architecture/core/api/end_points.dart';
import 'package:shop_clean_architecture/features/cart/data/models/change_cart_model.dart';
import 'package:shop_clean_architecture/features/cart/data/models/cart_model.dart';

import '../models/cart_model.dart';
import '../models/change_cart_model.dart';
import '../models/update_cart_model.dart';


abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
  Future<ChangeCartModel> changeCart({int? productID});
  Future<UpdateCartModel> updateCart({int? cartID,int? quantity});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final DioConsumer dioConsumer;

  CartRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<CartModel> getCart() async => await dioConsumer
      .get(ApiEndPoints.cart)
      .then((value) => CartModel.fromJson(value));

  @override
  Future<ChangeCartModel> changeCart({int? productID}) async => await dioConsumer
      .post(ApiEndPoints.cart,queryParameters: {'product_id':productID})
      .then((value) => ChangeCartModel.fromJson(value));

  @override
  Future<UpdateCartModel> updateCart({int? cartID,int? quantity})async => await dioConsumer
      .put('${ApiEndPoints.cart}/$cartID',queryParameters: {'quantity':quantity})
      .then((value) => UpdateCartModel.fromJson(value));



}
