import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/widgets/custom_text_form_field.dart';
import 'package:shop_clean_architecture/core/widgets/product_item_widget.dart';
import 'package:shop_clean_architecture/features/home/presentation/cubit/home_cubit.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/widgets/error_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return CustomTextFormField(
              controller: homeCubit.searchController,
              hintText: 'Search',
              keyboardType: TextInputType.text,
              onChanged: (value) => homeCubit.search(text: value),
              autofocus: true,
              suffixIcon: Icons.close,
              onPressedSuffixIcon: () => homeCubit.searchController.text.isEmpty
                  ? Navigator.pop(context)
                  : homeCubit.searchController.clear(),
              border: InputBorder.none,
            );
          },
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            return ErrorScreen(
              onTap: () => BlocProvider.of<HomeCubit>(context).getHomeData(),
            );
          } else if (state is SearchLoaded) {
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
                    itemCount: state.search.data?.data?.length,
                    itemBuilder: (context, index) {
                      final search = homeCubit.searchModel?.data?.data![index];
                      return ProductItemWidget(
                          isSearch: true,
                          routeName: Routes.searchDetailsScreen,
                          arguments: search,
                          name: search?.name,
                          image: search?.image,
                          price: search?.price,
                          id: search?.id);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
