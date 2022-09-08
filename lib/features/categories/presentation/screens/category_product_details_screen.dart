import 'package:flutter/material.dart';
import 'package:shop_clean_architecture/core/widgets/products_details_widget.dart';
import 'package:shop_clean_architecture/features/categories/data/models/category_details_model.dart';

class CategoryProductDetailsScreen extends StatelessWidget {
  const CategoryProductDetailsScreen(
      {Key? key, required this.categoriesDetails})
      : super(key: key);

  final CategoriesDetails categoriesDetails;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: ProductsDetailsWidget(
            name: categoriesDetails.name,
            discount: categoriesDetails.discount,
            description: categoriesDetails.description,
            price: categoriesDetails.price,
            oldPrice: categoriesDetails.oldPrice,
            images: categoriesDetails.images,
            id: categoriesDetails.id),
      );
}
