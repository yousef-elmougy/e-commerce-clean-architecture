import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/widgets/toggle_icon.dart';
import '../../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import 'cache_image.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget(
      {Key? key,
      required this.routeName,
      required this.arguments,
      required this.name,
      this.discount,
      required this.image,
      required this.price,
      this.oldPrice,
      required this.id,
      this.isSearch})
      : super(key: key);

  final String routeName;

  final Object? arguments;

  final String? name;
  final int? discount;
  final String? image;
  final double? price;
  final double? oldPrice;
  final int? id;
  final bool? isSearch ;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoritesCubit>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, routeName, arguments: arguments),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    return ToggleIcon(
                      onPressed: () =>
                          favoriteCubit.changeFavorites(context, productID: id),
                      isCheck: homeCubit.favorites[id],
                    );
                  },
                ),
             if(isSearch == false)
               if (discount != 0)
                  ColoredBox(
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT    $discount%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            CacheImage(
                image: "$image",
                height: 100,
                width: 100,
                boxFit: BoxFit.fill,
                iconSize: 70),
            Expanded(
              child: Text(
                '$name',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('EGP $price',
                    style: const TextStyle(color: Colors.blue, fontSize: 16)),
                if(isSearch == false)
                  if (discount != 0)
                  Text('$oldPrice',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
