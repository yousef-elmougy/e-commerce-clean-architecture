import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/widgets/cache_image.dart';
import 'package:shop_clean_architecture/features/favorites/data/models/favorites_model.dart';
import 'package:shop_clean_architecture/features/favorites/presentation/cubit/favorites_cubit.dart';

import '../../../home/presentation/cubit/home_cubit.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({Key? key, required this.favorite}) : super(key: key);
  final FavoriteProduct? favorite;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoritesCubit>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Row(
      children: [
        Stack(
          children: [
            CacheImage(
                image: '${favorite?.image}',
                height: 120,
                width: 120,
                boxFit: BoxFit.cover),
            if (favorite?.discount != 0)
              ColoredBox(
                color: Colors.red,
                child: Text(
                  'DISCOUNT    ${favorite?.discount}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              children: [
                Text(
                  '${favorite?.name}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('${favorite?.price}',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 16)),
                        const SizedBox(
                          width: 10,
                        ),
                        if (favorite?.discount != 0)
                          Text('${favorite?.oldPrice}',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () =>
                              favoriteCubit.changeFavorites(
                                  context,
                                  productID: favorite?.id),
                          icon: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              return Icon(
                                  homeCubit.favorites[favorite?.id] == true
                                      ? Icons.favorite
                                      : Icons.favorite_border);
                            },
                          ),
                          color: Colors.red,
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
