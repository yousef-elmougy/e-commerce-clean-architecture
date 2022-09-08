import 'package:flutter/material.dart';
import 'package:shop_clean_architecture/core/widgets/cache_image.dart';
import 'package:shop_clean_architecture/features/categories/data/models/categorise_model.dart';

import '../../../../config/routes/routes.dart';


class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.categoryData,
  }) : super(key: key);
  final CategoriesData? categoryData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, Routes.categoryDetailsScreen,arguments: categoryData),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        height: 100,
        child: GridTile(
          footer: Container(
            height: 30,
            width:double.infinity,
            color: Colors.black.withOpacity(.7),
            alignment: Alignment.center,
            child: Text(
              '${categoryData?.name.toString()}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          child:
          CacheImage(image: '${categoryData?.image.toString()}',boxFit:BoxFit.cover ),
        ),
      ),
    );
  }
}
