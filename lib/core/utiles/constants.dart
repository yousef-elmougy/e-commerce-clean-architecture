import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../error/failures.dart';
import 'app_colors.dart';
import 'app_strings.dart';

class AppConstants {
  static void showErrorDialog(
          {required BuildContext context, required String msg}) =>
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            msg,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                  primary: Colors.black,
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              child: const Text('Ok'),
            )
          ],
        ),
      );

  static void showToast(
          {required String msg, Color? color, ToastGravity? gravity}) =>
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: msg,
        backgroundColor: color ?? AppColors.primary,
        gravity: gravity ?? ToastGravity.BOTTOM,
      );

  static Future<bool> showExitPopup(context) async => await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Do you want to exit?"),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('yes selected');
                          }
                          exit(0);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade800),
                        child: const Text("Yes"),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('no selected');
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: const Text("No",
                          style: TextStyle(color: Colors.black)),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });

 static String mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      case OfflineFailure:
        return AppStrings.offlineFailure;

      default:
        return AppStrings.unExpectedError;
    }
  }
}
