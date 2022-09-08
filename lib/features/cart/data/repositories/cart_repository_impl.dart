import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/network/network_info.dart';
import 'package:shop_clean_architecture/features/cart/data/models/change_cart_model.dart';
import 'package:shop_clean_architecture/features/cart/data/models/update_cart_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/cart_local_data_source.dart';
import '../data_sources/cart_remote_data_source.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final NetworkInfo networkInfo;
  final CartRemoteDataSourceImpl cartRemoteDataSourceImpl;
  final CartLocalDataSourceImpl cartLocalDataSourceImpl;

  CartRepositoryImpl(
      {required this.networkInfo,
      required this.cartRemoteDataSourceImpl,
      required this.cartLocalDataSourceImpl});

  @override
  Future<Either<Failure, CartModel>> getCart() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCart = await cartRemoteDataSourceImpl.getCart();
        cartLocalDataSourceImpl.cacheCart(remoteCart);
        return Right(remoteCart);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheCart = await cartLocalDataSourceImpl.getCachedCart();
        return Right(cacheCart);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ChangeCartModel>> changeCart({int? productID}) async {
    if (await networkInfo.isConnected) {
      try {
      final changeCart =
          await cartRemoteDataSourceImpl.changeCart(productID: productID);
      return Right(changeCart);
    } on ServerException {
      return Left(ServerFailure());
    }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateCartModel>> updateCart({int? cartID, int? quantity}) async{
    if (await networkInfo.isConnected) {
      try {
      final updateCart =
          await cartRemoteDataSourceImpl.updateCart(cartID: cartID,quantity: quantity);
      return Right(updateCart);
    } on ServerException {
      return Left(ServerFailure());
    }
    }else{
      return Left(OfflineFailure());
    }
  }
}
