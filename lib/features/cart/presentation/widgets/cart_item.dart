import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/widgets/cache_image.dart';
import 'package:shop_clean_architecture/core/widgets/custom_space.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../data/models/cart_model.dart';
import '../cubit/cart_cubit.dart';

class CartItems extends StatelessWidget {
  const CartItems({Key? key, required this.cartProduct, required this.cartItem})
      : super(key: key);
  final CartProduct? cartProduct;
  final CartItem? cartItem;

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cartProduct?.discount != 0)
              ColoredBox(
                color: Colors.red,
                child: Text(
                  '  DISCOUNT    ${cartProduct?.discount}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            const VerticalSpace(1),
            CacheImage(
                image: '${cartProduct?.image}',
                height: 120,
                width: 120,
                boxFit: BoxFit.cover),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          int quantity = cartItem!.quantity! + 1;
                          if (quantity != 0) {
                            cartCubit.updateCart(
                                cartID: cartItem?.id, quantity: quantity);
                          }
                        },
                        icon: const Icon(Icons.add, size: 25)),
                    Text('${cartItem?.quantity}',
                        style: const TextStyle(fontSize: 20)),
                    IconButton(
                        onPressed: () {
                          int quantity = cartItem!.quantity! - 1;
                          if (quantity != 0) {
                            cartCubit.updateCart(
                                    cartID: cartItem?.id, quantity: quantity)
                                ;
                          }
                        },
                        icon: const Icon(Icons.remove, size: 25)),
                  ],
                );
              },
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              children: [
                Text(
                  '${cartProduct?.name}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('${cartProduct?.price}',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 16)),
                        const SizedBox(
                          width: 10,
                        ),
                        if (cartProduct?.discount != 0)
                          Text('${cartProduct?.oldPrice}',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () => cartCubit.changeCart(context,
                              productID: cartProduct?.id),
                          icon: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              return homeCubit.cart[cartProduct?.id] == true
                                  ? const Icon(Icons.shopping_cart,
                                      color: Colors.green)
                                  : const Icon(Icons.add_shopping_cart,
                                      color: Colors.grey);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
