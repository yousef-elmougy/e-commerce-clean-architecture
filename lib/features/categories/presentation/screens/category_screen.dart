import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import 'package:shop_clean_architecture/core/widgets/cache_image.dart';
import 'package:shop_clean_architecture/core/widgets/error_screen.dart';
import 'package:shop_clean_architecture/features/categories/presentation/cubit/categories_cubit.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryCubit = BlocProvider.of<CategoriesCubit>(context);
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCategoriesError) {
          return ErrorScreen(
            onTap: () => categoryCubit.getCategoriesData(),
          );
        } else {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () => context.goTo(Routes.categoryDetailsScreen,
                      args: categoryCubit.categoriesModel?.data?.data![index]),
                  child: SizedBox(
                    height: context.heightInPercent(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CacheImage(
                            image:
                                '${categoryCubit.categoriesModel?.data?.data![index].image}',
                            width: context.widthInPercent(30),
                            height: context.heightInPercent(15),
                            boxFit: BoxFit.cover),
                        Text(
                          '${categoryCubit.categoriesModel?.data?.data![index].name}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
