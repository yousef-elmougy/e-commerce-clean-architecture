import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/features/categories/data/models/categorise_model.dart';
import 'package:shop_clean_architecture/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:shop_clean_architecture/features/categories/domain/use_cases/get_category_details_usecase.dart';
import '../../../../core/utiles/constants.dart';
import '../../data/models/category_details_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(
      {required this.getCategoryDetailsUseCase,
      required this.getCategoriesUseCase})
      : super(CategoriesInitial());
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesModel? categoriesModel;

  Future<void> getCategoriesData() async {
    emit(GetCategoriesLoading());
    await getCategoriesUseCase().then((value) => value.fold(
            (failure) =>
                emit(GetCategoriesError(AppConstants.mapFailureToMsg(failure))),
            (value) {
          categoriesModel = value;
          emit(GetCategoriesLoaded(value));
        }));
  }

  final GetCategoryDetailsUseCase getCategoryDetailsUseCase;

  CategoryDetailsModel? categoryDetailsModel;

  Future<void> getCategoryDetails({int? categoryID}) async {
    emit(GetCategoryDetailsLoading());
    await getCategoryDetailsUseCase(categoryID: categoryID).then((value) =>
        value.fold(
            (failure) => emit(
                GetCategoryDetailsError(AppConstants.mapFailureToMsg(failure))),
            (value) {
          categoryDetailsModel = value;
          emit(GetCategoryDetailsLoaded(value));
        }));
  }
}
