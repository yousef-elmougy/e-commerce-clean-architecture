import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/widgets/toggle_icon.dart';

import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/widgets/custom_slider.dart';
import 'cache_image.dart';
import 'custom_space.dart';

class ProductsDetailsWidget extends StatelessWidget {
  const ProductsDetailsWidget(
      {Key? key,
      required this.name,
       this.discount,
      required this.description,
      required this.price,
       this.oldPrice,
      required this.images,
      required this.id})
      : super(key: key);

  final String? name;
  final int? discount;
  final String? description;
  final double? price;
  final double? oldPrice;
  final List? images;
  final int ?id;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoritesCubit>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const VerticalSpace(2),
            if (discount != 0)
              ColoredBox(
                color: Colors.red,
                child: Text(
                  'DISCOUNT    $discount%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            const VerticalSpace(1),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('EGP $price',
                        style: const TextStyle(
                            color: Colors.blue, fontSize: 20)),
                    Row(
                      children: [
                        BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, state) {
                            return ToggleIcon(
                              onPressed: () => favoriteCubit
                                  .changeFavorites(context, productID: id),
                              isCheck: homeCubit.favorites[id],
                            );
                          },
                        ),
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            return ToggleIcon(
                              onPressed: () => cartCubit.changeCart(context,
                                  productID: id),
                              isCheck: homeCubit.cart[id],
                              trueIcon: Icons.shopping_cart,
                              falseIcon: Icons.add_shopping_cart,
                              trueIconColor: Colors.green,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (discount != 0)
                  Text('$oldPrice',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough)),
              ],
            ),
            const VerticalSpace(2),
            CustomSlider(
              itemCount: images?.length,
              itemBuilder: (context, index, realIndex) => CacheImage(
                  image: '${images![index]}',
                  boxFit: BoxFit.fill,
                  iconSize: 70),
            ),
            const VerticalSpace(2),
            const Text('Overview :',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const VerticalSpace(2),
            Text(description.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
