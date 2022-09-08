import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utiles/app_strings.dart';
import '../../../../../core/utiles/assets_manager.dart';
import '../../onboarding_model.dart';
import 'onboarding_state.dart';


class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({required this.sharedPreferences}) :super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final SharedPreferences sharedPreferences;

  int selectedPageIndex = 0;
  var pageController = PageController();

  onPageChanged(int index) {
    selectedPageIndex = index;
    emit(OnBoardingSuccessState());
  }

  bool get lastPage => selectedPageIndex == onBoardingPages.length -1 ;

  Future<void> cacheOnBoarding()=> sharedPreferences.setBool(AppStrings.onBoardingKey, true);

  List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
      image: ImgAssets.orderImage,
      title: AppStrings.orderTitle,
      description: AppStrings.orderDesc,
    ),
    OnBoardingModel(
      image: ImgAssets.cookImage,
      title: AppStrings.cookTitle,
      description: AppStrings.cookDesc,
    ),
    OnBoardingModel(
      image: ImgAssets.deliverImage,
      title: AppStrings.deliverTitle,
      description: AppStrings.deliverDesc,
    )
  ];

}