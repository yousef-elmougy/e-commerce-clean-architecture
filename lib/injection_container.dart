import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_architecture/config/localization/cubit/locale_cubit.dart';
import 'package:shop_clean_architecture/config/localization/data/locale_data_source.dart';
import 'package:shop_clean_architecture/config/localization/data/locale_repository_impl.dart';
import 'package:shop_clean_architecture/config/localization/domain/use_cases/save_locale_usecase.dart';
import 'package:shop_clean_architecture/config/themes/cubit/theme_cubit.dart';
import 'package:shop_clean_architecture/features/address/domain/use_cases/get_address_usecase.dart';
import 'package:shop_clean_architecture/features/address/presentation/cubit/address_cubit.dart';
import 'package:shop_clean_architecture/features/cart/domain/use_cases/change_cart_usecase.dart';
import 'package:shop_clean_architecture/features/cart/domain/use_cases/update_cart_usecase.dart';
import 'package:shop_clean_architecture/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shop_clean_architecture/features/categories/data/data_sources/categories_local_data_source.dart';
import 'package:shop_clean_architecture/features/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:shop_clean_architecture/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:shop_clean_architecture/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:shop_clean_architecture/features/categories/domain/use_cases/get_category_details_usecase.dart';
import 'package:shop_clean_architecture/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:shop_clean_architecture/features/favorites/data/data_sources/favorites_local_data_source.dart';
import 'package:shop_clean_architecture/features/favorites/data/data_sources/favorites_remote_data_source.dart';
import 'package:shop_clean_architecture/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:shop_clean_architecture/features/favorites/domain/use_cases/change_favorites_usecase.dart';
import 'package:shop_clean_architecture/features/favorites/domain/use_cases/get_favorites_usecase.dart';
import 'package:shop_clean_architecture/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:shop_clean_architecture/features/home/data/data_sources/home_local_data_source.dart';
import 'package:shop_clean_architecture/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:shop_clean_architecture/features/home/data/repositories/home_repository_impl.dart';
import 'package:shop_clean_architecture/features/home/domain/use_cases/get_home_usecase.dart';
import 'package:shop_clean_architecture/features/home/domain/use_cases/search_usecase.dart';
import 'package:shop_clean_architecture/features/home/presentation/cubit/home_cubit.dart';
import 'package:shop_clean_architecture/features/layout/cubit/layout_cubit.dart';
import 'package:shop_clean_architecture/features/user/data/data_sources/local_data_source/user_local_data_source.dart';
import 'package:shop_clean_architecture/features/user/data/data_sources/remote_date_source/remote_user_data_source_impl.dart';
import 'package:shop_clean_architecture/features/user/data/repositories/user_repository_impl.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_change_password_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_login_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_logout_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_profile_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_register_usecase.dart';
import 'package:shop_clean_architecture/features/user/domain/use_cases/user_update_profile_usecase.dart';
import 'config/localization/domain/use_cases/get_save_locale_usecase.dart';
import 'core/api/api_interceptor.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'features/address/data/data_sources/address_remote_data_source.dart';
import 'features/address/data/data_sources/adress_local_data_source.dart';
import 'features/address/data/repositories/address_repository_impl.dart';
import 'features/address/domain/use_cases/add_address_usecase.dart';
import 'features/address/domain/use_cases/delete_address_usecase.dart';
import 'features/address/domain/use_cases/update_address_usecase.dart';
import 'features/cart/data/data_sources/cart_local_data_source.dart';
import 'features/cart/data/data_sources/cart_remote_data_source.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/use_cases/get_cart_usecase.dart';
import 'features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'features/user/presentation/cubit/user/user_cubit.dart';
import 'features/user/presentation/cubit/visibility/visibility_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  /// FEATURES
  // BLOC
  sl.registerFactory(() => OnBoardingCubit(sharedPreferences: sl()));
  sl.registerFactory(() => VisibilityCubit());
  sl.registerFactory(() => LayoutCubit());
  sl.registerFactory(
      () => HomeCubit(getHomeDataUseCase: sl(), searchUseCase: sl()));
  sl.registerFactory(() => CategoriesCubit(
      getCategoriesUseCase: sl(), getCategoryDetailsUseCase: sl()));
  sl.registerFactory(() =>
      FavoritesCubit(getFavoritesUseCase: sl(), changeFavoritesUseCase: sl()));
  sl.registerFactory(() => CartCubit(
      updateCartUseCase: sl(), getCartUseCase: sl(), changeCartUseCase: sl()));
  sl.registerFactory(() => ThemeCubit(sharedPreferences: sl()));
  sl.registerFactory(
      () => LocaleCubit(getSavedLocaleUseCase: sl(), saveLocaleUseCase: sl()));
  sl.registerFactory(() => AddressCubit(
      getAddressUseCase: sl(),
      addAddressUseCase: sl(),
      updateAddressUseCase: sl(),
      deleteAddressUseCase: sl()));
  sl.registerFactory(() => UserCubit(
      userProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      userLogOutUseCase: sl(),
      userRegisterUseCase: sl(),
      userChangePasswordUseCase: sl(),
      userLoginUseCase: sl(),
      localUserDataSourceImpl: sl()));
// USE CASE
  sl.registerLazySingleton(() => UserLoginUseCase(userRepositoryImpl: sl()));
  sl.registerLazySingleton(() => UserRegisterUseCase(userRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => UserChangePasswordUseCase(userRepositoryImpl: sl()));
  sl.registerLazySingleton(() => UserProfileUseCase(userRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => UserUpdateProfileUseCase(userRepositoryImpl: sl()));
  sl.registerLazySingleton(() => UserLogOutUseCase(userRepositoryImpl: sl()));
  sl.registerLazySingleton(() => GetHomeDataUseCase(homeRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => GetCategoriesUseCase(categoriesRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => GetCategoryDetailsUseCase(categoriesRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => GetFavoritesUseCase(favoritesRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => ChangeFavoritesUseCase(favoritesRepositoryImpl: sl()));
  sl.registerLazySingleton(() => SearchUseCase(homeRepositoryImpl: sl()));
  sl.registerLazySingleton(() => UpdateCartUseCase(cartRepositoryImpl: sl()));
  sl.registerLazySingleton(() => ChangeCartUseCase(cartRepositoryImpl: sl()));
  sl.registerLazySingleton(() => GetCartUseCase(cartRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => GetAddressUseCase(addressRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => AddAddressUseCase(addressRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => UpdateAddressUseCase(addressRepositoryImpl: sl()));
  sl.registerLazySingleton(
      () => DeleteAddressUseCase(addressRepositoryImpl: sl()));
  sl.registerLazySingleton(() => SaveLocaleUseCase(localeRepositoryImpl: sl()));
  sl.registerLazySingleton(() => GetSavedLocaleUseCase(localeRepositoryImpl: sl()));

  // REPOSITORY
  sl.registerLazySingleton(() => UserRepositoryImpl(
      remoteUserDataSourceImpl: sl(),
      localUserDataSourceImpl: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton(() => HomeRepositoryImpl(
      networkInfo: sl(),
      homeRemoteDataSourceImpl: sl(),
      homeLocalDataSourceImpl: sl()));
  sl.registerLazySingleton(() => CategoriesRepositoryImpl(
      networkInfo: sl(),
      categoriesRemoteDataSourceImpl: sl(),
      categoriesLocalDataSourceImpl: sl()));
  sl.registerLazySingleton(() => FavoritesRepositoryImpl(
      networkInfo: sl(),
      favoritesRemoteDataSourceImpl: sl(),
      favoritesLocalDataSourceImpl: sl()));
  sl.registerLazySingleton(() => CartRepositoryImpl(
      networkInfo: sl(),
      cartRemoteDataSourceImpl: sl(),
      cartLocalDataSourceImpl: sl()));
  sl.registerLazySingleton(() => AddressRepositoryImpl(
      networkInfo: sl(),
      addressRemoteDataSourceImpl: sl(),
      addressLocalDataSourceImpl: sl()));
  sl.registerLazySingleton(
      () => LocaleRepositoryImpl(networkInfo: sl(), localeDataSourceImpl: sl()));
  // DATA SOURCE
// LOCAL DATA SOURCE
  sl.registerLazySingleton(
      () => LocalUserDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => HomeLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => CategoriesLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => FavoritesLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => CartLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => AddressLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => LocaleDataSourceImpl(sharedPreferences: sl()));
// REMOTE DATA SOURCE
  sl.registerLazySingleton(() => RemoteUserDataSourceImpl(dioConsumer: sl()));
  sl.registerLazySingleton(() => HomeRemoteDataSourceImpl(dioConsumer: sl()));
  sl.registerLazySingleton(
      () => CategoriesRemoteDataSourceImpl(dioConsumer: sl()));
  sl.registerLazySingleton(
      () => FavoritesRemoteDataSourceImpl(dioConsumer: sl()));
  sl.registerLazySingleton(() => CartRemoteDataSourceImpl(dioConsumer: sl()));
  sl.registerLazySingleton(
      () => AddressRemoteDataSourceImpl(dioConsumer: sl()));

  /// CORE
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => DioConsumer(client: sl()));

  /// EXTERNAL
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
}
