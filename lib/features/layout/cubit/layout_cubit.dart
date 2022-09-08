import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/features/cart/presentation/screens/cart_screen.dart';
import '../../categories/presentation/screens/category_screen.dart';
import '../../favorites/presentation/screens/favorites_screen.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../settings/screens/settings_screen.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int currentIndex = 0;

  bottomNavToggle(int index){
    currentIndex = index;

    emit(BottomNavToggle());
  }

  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];


}
