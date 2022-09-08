import 'package:flutter/material.dart';
import 'package:shop_clean_architecture/core/widgets/products_details_widget.dart';
import 'package:shop_clean_architecture/features/home/data/models/search_model.dart';

class SearchDetailsScreen extends StatelessWidget {
  const SearchDetailsScreen({Key? key, required this.search}) : super(key: key);

  final SearchData search;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Search Details')),
        body: ProductsDetailsWidget(
            name: search.name,
            description: search.description,
            price: search.price,
            images: search.images,
            id: search.id),
      );
}
