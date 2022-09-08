import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utiles/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.black,

    /// ICON THEME
    iconTheme: const IconThemeData(color: AppColors.black),

    /// DIVIDER THEME
    dividerTheme: const DividerThemeData(
        thickness: 1, color: AppColors.black, endIndent: 20, indent: 20),

    /// LIST TILE THEME
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.black,
      textColor: AppColors.black,
    ),

    /// SWITCH THEME
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.white),
      trackColor: MaterialStateProperty.all(AppColors.grey),
    ),

    /// APP BAR THEME

    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    /// BOTTOM NAVIGATION BAR THEME

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      unselectedIconTheme: IconThemeData(
        color: AppColors.grey,
      ),
      selectedItemColor: AppColors.black,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(color: AppColors.black),
      selectedLabelStyle: TextStyle(color: AppColors.black),
      unselectedItemColor: AppColors.grey,
    ),

    /// TEXT THEME

    textTheme: const TextTheme(
      headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    ),

    /// TEXT FORM FIELD THEME

    inputDecorationTheme: const InputDecorationTheme(
      //   prefixIconColor: AppColors.black ,
      //   iconColor:  AppColors.black,
      //   fillColor:  AppColors.black,
      // helperStyle: TextStyle(color: AppColors.black),
      //   counterStyle: TextStyle(color: AppColors.black),
      //   focusColor: AppColors.black,
      //   hoverColor: AppColors.black,
      //   floatingLabelStyle: TextStyle(color: AppColors.black) ,
      //   prefixStyle: TextStyle(color: AppColors.black) ,
      //   suffixStyle:TextStyle(color: AppColors.black) ,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      labelStyle: TextStyle(
        // fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      suffixIconColor: AppColors.black,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
      selectionColor: AppColors.black,
      selectionHandleColor: AppColors.black,
    ),
  );

  /// ############################################################################################################################## ///

  static final dark = ThemeData(
    scaffoldBackgroundColor: AppColors.dark,
    primaryColor: AppColors.white,

    /// ICON THEME
    iconTheme: const IconThemeData(color: AppColors.white),

    /// DIVIDER THEME
    dividerTheme: const DividerThemeData(
        thickness: 1, color: AppColors.white, endIndent: 20, indent: 20),

    /// LIST TILE THEME
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.white,
      textColor: AppColors.white,
    ),

    /// SWITCH THEME
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.white),
      trackColor: MaterialStateProperty.all(AppColors.white),
    ),

    /// APP BAR THEME

    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: AppColors.dark,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    /// BOTTOM NAVIGATION BAR THEME

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.dark,
      unselectedIconTheme: IconThemeData(
        color: AppColors.grey,
      ),
      selectedItemColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(color: AppColors.white),
      selectedLabelStyle: TextStyle(color: AppColors.white),
      unselectedItemColor: AppColors.grey,
    ),

    /// TEXT THEME

    textTheme: const TextTheme(
      headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),

    /// TEXT FORM FIELD THEME

    inputDecorationTheme: const InputDecorationTheme(
      //   prefixIconColor: AppColors.white ,
      //   iconColor:  AppColors.white,
      //   fillColor:  AppColors.white,
      // helperStyle: TextStyle(color: AppColors.white),
      //   counterStyle: TextStyle(color: AppColors.white),
      //   focusColor: AppColors.white,
      //   hoverColor: AppColors.white,
      //   floatingLabelStyle: TextStyle(color: AppColors.white) ,
      //   prefixStyle: TextStyle(color: AppColors.white) ,
      //   suffixStyle:TextStyle(color: AppColors.white) ,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      labelStyle: TextStyle(
        // fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      suffixIconColor: AppColors.white,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.white,
      selectionColor: AppColors.white,
      selectionHandleColor: AppColors.white,
    ),
  );
}
