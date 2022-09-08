import 'package:flutter/material.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';

import '../cubit/onboarding_cubit.dart';

class OnBoardingFloatingBottom extends StatelessWidget {
  const OnBoardingFloatingBottom({
    Key? key,
    required this.onBoardingCubit,
  }) : super(key: key);

  final OnBoardingCubit onBoardingCubit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (onBoardingCubit.lastPage) {
            onBoardingCubit.cacheOnBoarding();
            Navigator.pushReplacementNamed(context, Routes.loginScreen);
          } else {
            onBoardingCubit.pageController.nextPage(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease);
          }
        },
        child: Text(onBoardingCubit.lastPage ? 'Start' : 'Next'),
      ),
    );
  }
}
