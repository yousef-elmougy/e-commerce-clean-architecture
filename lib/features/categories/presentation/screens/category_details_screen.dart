import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/widgets/product_item_widget.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../data/models/categorise_model.dart';
import '../cubit/categories_cubit.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({Key? key, required this.categoriesData})
      : super(key: key);

  final CategoriesData categoriesData;

  @override
  Widget build(BuildContext context) {
    final categoryCubit = BlocProvider.of<CategoriesCubit>(context);
    categoryCubit.getCategoryDetails(categoryID: categoriesData.id);
    return Scaffold(
      appBar: AppBar(title: Text('${categoriesData.name} Details')),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (BuildContext context, state) {
          if (state is GetCategoryDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetCategoryDetailsError) {
            return ErrorScreen(
              onTap: () => categoryCubit.getCategoryDetails(),
            );
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .75,
                    ),
                    itemCount:
                        categoryCubit.categoryDetailsModel?.data?.data?.length,
                    itemBuilder: (context, index) {
                      final category = categoryCubit
                          .categoryDetailsModel?.data?.data?[index];
                      return ProductItemWidget(
                        isSearch: false,
                        routeName: Routes.categoryProductDetailsScreen,
                        arguments: category,
                        name: category?.name,
                        image: category?.image,
                        price: category?.price,
                        id: category?.id,
                        discount: category?.discount,
                        oldPrice: category?.oldPrice,
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
