import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/localization/cubit/locale_cubit.dart';
import 'config/routes/app_router.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/cubit/theme_cubit.dart';
import 'features/address/presentation/cubit/address_cubit.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/categories/presentation/cubit/categories_cubit.dart';
import 'features/favorites/presentation/cubit/favorites_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/layout/cubit/layout_cubit.dart';
import 'features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'features/user/presentation/cubit/user/user_cubit.dart';
import 'features/user/presentation/cubit/visibility/visibility_cubit.dart';
import 'package:shop_clean_architecture/injection_container.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnBoardingCubit>(
            create: (context) => di.sl<OnBoardingCubit>()),
        BlocProvider<UserCubit>(create: (context) => di.sl<UserCubit>()),
        BlocProvider<VisibilityCubit>(
            create: (context) => di.sl<VisibilityCubit>()),
        BlocProvider<LayoutCubit>(create: (context) => di.sl<LayoutCubit>()),
        BlocProvider<HomeCubit>(
            create: (context) => di.sl<HomeCubit>()..getHomeData()),
        BlocProvider<CategoriesCubit>(
            create: (context) => di.sl<CategoriesCubit>()..getCategoriesData()),
        BlocProvider<FavoritesCubit>(
            create: (context) => di.sl<FavoritesCubit>()..getFavorites()),
        BlocProvider<CartCubit>(
            create: (context) => di.sl<CartCubit>()..getCart()),
        BlocProvider<AddressCubit>(
            create: (context) => di.sl<AddressCubit>()..getAddress()),
        BlocProvider<ThemeCubit>(create: (context) => di.sl<ThemeCubit>()),
        BlocProvider<LocaleCubit>(create: (context) => di.sl<LocaleCubit>()..getSavedLocale()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final theme = BlocProvider.of<ThemeCubit>(context).themeDataGet;
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return MaterialApp(
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: theme,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.onGenerateRoute,
                locale: state.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                localeResolutionCallback: (locale, supportedLocales) {
                  for (Locale supportedLocale in supportedLocales) {
                    if (locale != null &&
                        supportedLocale.languageCode == locale.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.last;
                },
              );
            },
          );
        },
      ),
    );
  }
}

// class RestartWidget extends StatefulWidget {
//   const RestartWidget({Key? key, this.child}) : super(key: key);
//
//   final Widget? child;
//
//   static void restartApp(BuildContext context) =>
//       context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
//
//   @override
//   State<StatefulWidget> createState() => _RestartWidgetState();
// }
//
// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();
//
//   void restartApp() => setState(() => key = UniqueKey());
//
//   @override
//   Widget build(BuildContext context) =>
//       KeyedSubtree(key: key, child: widget.child ?? Container());
// }