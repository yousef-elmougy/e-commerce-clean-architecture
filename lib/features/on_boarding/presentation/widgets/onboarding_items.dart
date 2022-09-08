import 'package:flutter/material.dart';

import '../cubit/onboarding_cubit.dart';

class OnBoardingItems extends StatelessWidget {
  const OnBoardingItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onBoardingCubit = OnBoardingCubit.get(context);
    return  PageView.builder(
        controller: onBoardingCubit.pageController,
        onPageChanged: (index) =>
            onBoardingCubit.onPageChanged(index),
        itemCount: onBoardingCubit.onBoardingPages.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(onBoardingCubit
                  .onBoardingPages[index].image
                  .toString()),
              const SizedBox(height: 32),
              Text(
                onBoardingCubit.onBoardingPages[index].title
                    .toString(),
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 64.0),
                child: Text(
                  onBoardingCubit.onBoardingPages[index].description
                      .toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        });
  }
}
