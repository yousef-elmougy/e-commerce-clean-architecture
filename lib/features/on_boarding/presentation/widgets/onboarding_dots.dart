import 'package:flutter/material.dart';

import '../cubit/onboarding_cubit.dart';

class OnBoardingDots extends StatelessWidget {
  const OnBoardingDots({
    Key? key,
    required this.onBoardingCubit,
  }) : super(key: key);

  final OnBoardingCubit onBoardingCubit;

  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: 20,
      left: 20,
      child: Row(
        children: List.generate(
          onBoardingCubit.onBoardingPages.length,
              (index) {
            return Container(
              margin: const EdgeInsets.all(4),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: onBoardingCubit.selectedPageIndex == index
                    ? Colors.red
                    : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }
}
