import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_floating_bottom.dart';
import '../widgets/onboarding_items.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onBoardingCubit = OnBoardingCubit.get(context);
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                const OnBoardingItems(),
                OnBoardingDots(onBoardingCubit: onBoardingCubit),
                OnBoardingFloatingBottom(onBoardingCubit: onBoardingCubit),
              ],
            ),
          ),
        );
      },
    );
  }
}



