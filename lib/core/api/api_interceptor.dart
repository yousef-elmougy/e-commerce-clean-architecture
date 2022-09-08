import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utiles/app_strings.dart';
import 'package:shop_clean_architecture/injection_container.dart' as di;
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations_ar.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers = {
      AppStrings.lang:
          di.sl<SharedPreferences>().getString(AppStrings.localeKey) ==
                  AppStrings.englishCode
              ? AppStrings.englishCode
              : AppStrings.arabicCode,
      AppStrings.contentType: AppStrings.applicationJson,
      AppStrings.authorization:
          di.sl<SharedPreferences>().getString(AppStrings.tokenKey)
    };
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
