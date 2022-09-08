import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/widgets/empty_widget.dart';
import '../../../../core/widgets/error_screen.dart';
import '../cubit/favorites_cubit.dart';
import '../widgets/favorite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (BuildContext context, state) {
        if (state is GetFavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetFavoritesError) {
          return ErrorScreen(
            onTap: () => favoriteCubit.getFavorites(),
          );
        } else {
          if (favoriteCubit.favoritesModel!.data!.data!.isEmpty) {
            return const EmptyWidget(
                icon: Icons.favorite_border, text: 'Add Some Favorites');
          } else {
            return ListView.separated(
              itemCount:
                  favoriteCubit.favoritesModel?.data?.data?.length ?? 0,
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 3),
              itemBuilder: (context, index) => FavoriteItem(
                  favorite: favoriteCubit
                      .favoritesModel?.data?.data?[index].product),
            );
          }
        }
      },
    );
  }
}
