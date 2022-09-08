import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/extentions/media_query_extension.dart';
import '../utiles/app_colors.dart';


class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // final localeCubit = BlocProvider.of<LocaleCubit>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber, color: AppColors.primary, size: 150),
            const SizedBox(height: 40),
            Text('ERROR',
              // localeCubit.tr(context).dateOfBirth,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text('SOME THING WENT WRONG !!',
              // localeCubit.tr(context).email,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                height: context.height * .07,
                width: context.width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text('reload',
                    // localeCubit.tr(context).personalInformation,
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
