import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import 'cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () => context.goTo(Routes.searchScreen),
              icon: const Icon(Icons.search),
            ),
          ),
        ],
        title: const Text('SALLA'),
      ),
      bottomNavigationBar: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (BuildContext context, state) {
          return BottomNavigationBar(
            currentIndex: layoutCubit.currentIndex,
            onTap: layoutCubit.bottomNavToggle,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ],
          );
        },
      ),
      body: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (BuildContext context, state) {
          return IndexedStack(
            index: layoutCubit.currentIndex,
            children: layoutCubit.screens,
          );
        },
      ),
    );
  }
}
