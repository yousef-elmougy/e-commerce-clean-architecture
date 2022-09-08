part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class GetCartLoading extends CartState {}

class GetCartLoaded extends CartState {
  final CartModel cartModel;

  GetCartLoaded(this.cartModel);
}

class GetCartError extends CartState {
  final String error;

  GetCartError(this.error);
}

class ChangeCartLoading extends CartState {}

class ChangeCartLoaded extends CartState {
  final ChangeCartModel changeCartModel;

  ChangeCartLoaded(this.changeCartModel);
}

class ChangeCartError extends CartState {
  final String error;

  ChangeCartError(this.error);
}

class UpdateCartLoading extends CartState {}

class UpdateCartLoaded extends CartState {
  final UpdateCartModel updateCartModel;

  UpdateCartLoaded(this.updateCartModel);
}

class UpdateCartError extends CartState {
  final String error;

  UpdateCartError(this.error);
}

