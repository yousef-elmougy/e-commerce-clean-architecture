import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/features/home/data/models/home_model.dart';
import 'package:shop_clean_architecture/features/home/data/models/search_model.dart';
import 'package:shop_clean_architecture/features/home/domain/use_cases/get_home_usecase.dart';
import 'package:shop_clean_architecture/features/home/domain/use_cases/search_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.searchUseCase, required this.getHomeDataUseCase})
      : super(HomeInitial());

  Map<dynamic, dynamic> favorites = {};
  Map<dynamic, dynamic> cart = {};

  final GetHomeDataUseCase getHomeDataUseCase;
  HomeModel? homeModel;

  Future<void> getHomeData() async {
    emit(GetHomeDataLoading());
    await getHomeDataUseCase().then((value) => value.fold(
            (failure) =>
                emit(GetHomeDataError(AppConstants.mapFailureToMsg(failure))),
            (value) {
          homeModel = value;
          homeModel?.data?.products?.forEach(
              (element) => favorites.addAll({element.id: element.inFavorites}));

          homeModel?.data?.products
              ?.forEach((element) => cart.addAll({element.id: element.inCart}));

          emit(GetHomeDataLoaded(value));
        }));
  }

  final SearchUseCase searchUseCase;
  SearchModel? searchModel;
  final searchController = TextEditingController();

  Future<void> search({String? text}) async {
    emit(SearchLoading());
    await searchUseCase(text: text).then((value) => value.fold(
            (failure) =>
                emit(SearchError(AppConstants.mapFailureToMsg(failure))),
            (value) {
          searchModel = value;
          emit(SearchLoaded(value));
        }));
  }
}
