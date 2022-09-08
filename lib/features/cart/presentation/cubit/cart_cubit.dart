import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/features/cart/data/models/cart_model.dart';
import 'package:shop_clean_architecture/features/cart/domain/use_cases/update_cart_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utiles/app_strings.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../data/models/change_cart_model.dart';
import '../../data/models/update_cart_model.dart';
import '../../domain/use_cases/change_cart_usecase.dart';
import '../../domain/use_cases/get_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
      {required this.updateCartUseCase,
      required this.getCartUseCase,
      required this.changeCartUseCase})
      : super(CartInitial());

  /// GET CART
  final GetCartUseCase getCartUseCase;

  CartModel? cartModel;

  Future<void> getCart() async {
    emit(GetCartLoading());
    final cart = await getCartUseCase();
    cart.fold(
        (failure) => emit(GetCartError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      cartModel = value;
      emit(GetCartLoaded(value));
    });
  }

  /// CHANGE CART
  final ChangeCartUseCase changeCartUseCase;
  ChangeCartModel? changeCartModel;

  void changeCartIcon(context, int? productID) {
    BlocProvider.of<HomeCubit>(context).cart[productID] =
        !(BlocProvider.of<HomeCubit>(context).cart[productID]);
  }

  Future<void> changeCart(context, {int? productID}) async {
    changeCartIcon(context, productID);
    emit(ChangeCartLoading());
    final changeCart = await changeCartUseCase(productID: productID);
    changeCart.fold((failure) {
      changeCartIcon(context, productID);
      emit(ChangeCartError(AppConstants.mapFailureToMsg(failure)));
    }, (value) {
      changeCartModel?.status == false
          ? changeCartIcon(context, productID)
          : getCart();
      emit(ChangeCartLoaded(value));
    });
  }

  /// UPDATE CART

  final UpdateCartUseCase updateCartUseCase;

  // UpdateCartModel? updateCartModel;

  Future<void> updateCart({int? cartID, int? quantity}) async {
    getCart();
    emit(UpdateCartLoading());
    final updateCart =
        await updateCartUseCase(cartID: cartID, quantity: quantity);
    updateCart.fold(
        (failure) =>
            emit(UpdateCartError(AppConstants.mapFailureToMsg(failure))),
        (value) {
      // updateCartModel = value;
      emit(UpdateCartLoaded(value));
    });
  }
}
