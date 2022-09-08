import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/config/themes/cubit/theme_cubit.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../core/widgets/error_screen.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return BlocBuilder<CartCubit, CartState>(
      builder: (BuildContext context, state) {
        if (state is GetCartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCartError) {
          return ErrorScreen(
            onTap: () => cartCubit.getCart(),
          );
        } else {
          if (cartCubit.cartModel!.data!.cartItems!.isEmpty) {
            return const EmptyWidget(
                icon: Icons.add_shopping_cart, text: 'Add Some Products');
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount:
                        cartCubit.cartModel?.data?.cartItems?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 3),
                    itemBuilder: (context, index) => CartItems(
                      cartProduct:
                          cartCubit.cartModel?.data?.cartItems?[index].product,
                      cartItem: cartCubit.cartModel?.data?.cartItems?[index],
                    ),
                  ),
                ),
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return Container(
                      color: BlocProvider.of<ThemeCubit>(context).switchValue
                          ? AppColors.dark
                          : Colors.white,
                      width: double.infinity,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Sub Total',
                                    style: TextStyle(fontSize: 20)),
                                Text('${cartCubit.cartModel?.data?.subTotal}',
                                    style: const TextStyle(fontSize: 20)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total',
                                    style: TextStyle(fontSize: 20)),
                                Text('${cartCubit.cartModel?.data?.total}',
                                    style: const TextStyle(fontSize: 20)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }
      },
    );
  }
}
