import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/core/widgets/custom_space.dart';
import 'package:shop_clean_architecture/core/widgets/error_screen.dart';
import 'package:shop_clean_architecture/core/widgets/product_item_widget.dart';
import 'package:shop_clean_architecture/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:shop_clean_architecture/features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../user/presentation/cubit/user/user_cubit.dart';
import '../cubit/home_cubit.dart';
import '../widgets/category_item.dart';
import '../widgets/custom_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context)..getProfile();
    final cartCubit = BlocProvider.of<CartCubit>(context)..getCart();
    final favoriteCubit = BlocProvider.of<FavoritesCubit>(context)..getFavorites();
    final homeCubit = BlocProvider.of<HomeCubit>(context)..getHomeData();
    final categoryCubit = BlocProvider.of<CategoriesCubit>(context)..getCategoriesData();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetHomeDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetHomeDataError) {
          return ErrorScreen(
            onTap: () => BlocProvider.of<HomeCubit>(context).getHomeData(),
          );
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSlider(
                  itemCount: homeCubit.homeModel?.data?.banners?.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                      CacheImage(
                          image:
                          '${homeCubit.homeModel?.data?.banners?[itemIndex]
                              .image.toString()}',
                          boxFit: BoxFit.fill,
                          iconSize: 150),
                ),
                const VerticalSpace(1),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Categories',
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryCubit.categoriesModel?.data?.data
                        ?.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                        categoryData: categoryCubit.categoriesModel?.data
                            ?.data![index],
                      );
                    },
                  ),
                ),
                const VerticalSpace(1),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Products',
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .75,
                  ),
                  itemCount: homeCubit.homeModel?.data?.products?.length,
                  itemBuilder: (context, index) {
                    final product = homeCubit.homeModel?.data?.products![index];
                    return
                      ProductItemWidget(routeName: Routes.productDetailsScreen,
                          isSearch:  false,
                          arguments: product,
                          name: product?.name,
                          discount:  product?.discount,
                          image:  product?.image,
                          price:  product?.price,
                          oldPrice:  product?.oldPrice,
                          id:  product?.id);

                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
