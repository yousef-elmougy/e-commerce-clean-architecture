import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/core/utiles/app_strings.dart';
import 'package:shop_clean_architecture/features/address/data/models/address_model.dart';
import 'package:shop_clean_architecture/features/address/presentation/screens/add_address.dart';
import 'package:shop_clean_architecture/features/address/presentation/screens/update_address_screen.dart';
import 'package:shop_clean_architecture/features/categories/data/models/categorise_model.dart';
import 'package:shop_clean_architecture/features/categories/data/models/category_details_model.dart';
import 'package:shop_clean_architecture/features/categories/presentation/screens/category_details_screen.dart';
import 'package:shop_clean_architecture/features/categories/presentation/screens/category_product_details_screen.dart';
import 'package:shop_clean_architecture/features/home/data/models/home_model.dart';
import 'package:shop_clean_architecture/features/home/data/models/search_model.dart';
import 'package:shop_clean_architecture/features/home/presentation/screens/search_details.dart';
import 'package:shop_clean_architecture/features/home/presentation/screens/search_screen.dart';
import 'package:shop_clean_architecture/features/user/presentation/screens/login_screen.dart';
import 'package:shop_clean_architecture/features/user/presentation/screens/register_screen.dart';
import 'package:shop_clean_architecture/injection_container.dart' as di;
import '../../features/address/presentation/screens/address_screen.dart';
import '../../features/home/presentation/screens/product_details_screen.dart';
import '../../features/layout/layout_screen.dart';
import '../../features/on_boarding/presentation/screens/on_boarding_screen.dart';
import '../../features/settings/screens/change_password_screen.dart';
import '../../features/settings/screens/profile_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      /// SPLASH SCREEN
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// ON BOARDING SCREEN
      case Routes.onBoardingScreen:
        final prefs = di.sl<SharedPreferences>();
        return MaterialPageRoute(
          builder: (_) => prefs.getBool(AppStrings.onBoardingKey) ?? false
              ? prefs.getString(AppStrings.tokenKey) != null
                  ? const LayoutScreen()
                  : const LoginScreen()
              : const OnBoardingScreen(),
        );

      /// LOGIN SCREEN
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      /// REGISTER SCREEN
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      /// LAYOUT SCREEN
      case Routes.layoutScreen:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());

      /// PRODUCT DETAILS SCREEN

      case Routes.productDetailsScreen:
        final product = settings.arguments as HomeProduct;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(homeProduct: product));

      /// CATEGORY DETAILS SCREEN

      case Routes.categoryDetailsScreen:
        final category = settings.arguments as CategoriesData;

        return MaterialPageRoute(
            builder: (_) => CategoryDetailsScreen(categoriesData: category));

      /// CATEGORY PRODUCT DETAILS SCREEN

      case Routes.categoryProductDetailsScreen:
        final category = settings.arguments as CategoriesDetails;

        return MaterialPageRoute(
            builder: (_) =>
                CategoryProductDetailsScreen(categoriesDetails: category));

      /// SEARCH SCREEN

      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      /// SEARCH DETAILS SCREEN

      case Routes.searchDetailsScreen:
        final search = settings.arguments as SearchData;
        return MaterialPageRoute(
            builder: (_) => SearchDetailsScreen(search: search));

      /// ACCOUNT SCREEN

      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      /// PROFILE SCREEN

      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      /// CHANGE PASSWORD SCREEN

      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

        /// ADDRESS SCREEN

      case Routes.addressScreen:
        return MaterialPageRoute(builder: (_) => const AddressScreen());

          /// UPDATE ADDRESS SCREEN

      case Routes.updateAddressScreen:
        final address = settings.arguments as AddressData;
        return MaterialPageRoute(builder: (_) =>  UpdateAddressScreen(addressData: address));

          /// ADD ADDRESS SCREEN

      case Routes.addNewAddressScreen:
        return MaterialPageRoute(builder: (_) => const AddNewAddressScreen());

      default:
        return _defaultRoute();
    }
  }

  static MaterialPageRoute<dynamic> _defaultRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'ERROR : Route Not Found',
          ),
        ),
        body: const Center(
          child: Text(
            'ERROR : Route Not Found',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
