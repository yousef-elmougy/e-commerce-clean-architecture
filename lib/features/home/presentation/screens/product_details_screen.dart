import 'package:flutter/material.dart';
import 'package:shop_clean_architecture/core/widgets/products_details_widget.dart';
import 'package:shop_clean_architecture/features/home/data/models/home_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.homeProduct})
      : super(key: key);

  final HomeProduct homeProduct;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: ProductsDetailsWidget(
            name: homeProduct.name,
            discount: homeProduct.discount,
            description: homeProduct.description,
            price: homeProduct.price,
            oldPrice: homeProduct.oldPrice,
            images: homeProduct.images,
            id: homeProduct.id),
      );
}
