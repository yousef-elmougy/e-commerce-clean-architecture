import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_architecture/config/localization/cubit/locale_cubit.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/config/themes/cubit/theme_cubit.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import 'package:shop_clean_architecture/core/utiles/app_colors.dart';
import 'package:shop_clean_architecture/core/utiles/app_strings.dart';
import 'package:shop_clean_architecture/core/widgets/custom_space.dart';
import 'package:shop_clean_architecture/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:shop_clean_architecture/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:shop_clean_architecture/features/user/presentation/cubit/user/user_state.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../cart/presentation/cubit/cart_cubit.dart';
import '../../categories/presentation/cubit/categories_cubit.dart';
import '../../home/presentation/cubit/home_cubit.dart';
import '../widgets/custom_list_tile.dart';
import 'package:shop_clean_architecture/injection_container.dart' as di;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final categoryCubit = BlocProvider.of<CategoriesCubit>(context);
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Center(
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final userData = userCubit.userModel?.data;
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            return ErrorScreen(onTap: () => userCubit.getProfile());
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${userData?.image}'),
                      radius: 50,
                    ),
                    const HorizontalSpace(3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${userData?.name}',
                              style: const TextStyle(fontSize: 20)),
                          const VerticalSpace(3),
                          Text(
                            '${userData?.email}',
                            style: const TextStyle(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(2),
                const Divider(),
                CustomListTile(
                  text: 'Dark Mode',
                  icon: Icons.dark_mode,
                  trailing: BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      final themeCubit = BlocProvider.of<ThemeCubit>(context);
                      return Switch(
                          value: themeCubit.getCachedTheme(),
                          onChanged: (value) {
                            themeCubit.changeTheme();
                            themeCubit.changeSwitch(value);
                          });
                    },
                  ),
                ),
                CustomListTile(
                  text: 'Language',
                  icon: Icons.language,
                  trailing: BlocBuilder<LocaleCubit, LocaleState>(
                    builder: (context, state) {
                      final localeCubit = BlocProvider.of<LocaleCubit>(context);
                      return Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            iconSize: 25,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: [
                              buildDropdownMenuItem(
                                  'English 🇺🇸', AppStrings.englishCode),
                              buildDropdownMenuItem(
                                  'Arabic 🇸🇦', AppStrings.arabicCode),
                            ],
                            value: di
                                .sl<SharedPreferences>()
                                .getString(AppStrings.localeKey),
                            onChanged: (value) => localeCubit
                                .saveLocale(codeLange: '$value')
                                .then((value) {
                              homeCubit.getHomeData();
                              categoryCubit.getCategoriesData();
                              favoritesCubit.getFavorites();
                              cartCubit.getCart();
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomListTile(
                  text: 'Profile',
                  icon: Icons.person,
                  onTap: () => context.goTo(Routes.profileScreen),
                ),
                CustomListTile(
                  text: 'Address',
                  icon: Icons.location_on,
                  onTap: () => context.goTo(Routes.addressScreen),
                ),
                CustomListTile(
                  text: 'Log out',
                  icon: Icons.logout,
                  onTap: () => userCubit.logOut(context),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String text, String value) =>
      DropdownMenuItem(
        value: value,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.deepOrange,
          ),
        ),
      );
}
