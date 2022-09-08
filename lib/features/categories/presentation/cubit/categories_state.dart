part of 'categories_cubit.dart';

abstract class CategoriesState  {}

class CategoriesInitial extends CategoriesState {}

class GetCategoriesLoading extends CategoriesState {}
class GetCategoriesLoaded extends CategoriesState {
  final CategoriesModel categoriesModel;

  GetCategoriesLoaded(this.categoriesModel);

}
class GetCategoriesError extends CategoriesState {
  final String error;

  GetCategoriesError(this.error);

}

class GetCategoryDetailsLoading extends CategoriesState {}
class GetCategoryDetailsLoaded extends CategoriesState {
  final CategoryDetailsModel categoryDetailsModel;

  GetCategoryDetailsLoaded(this.categoryDetailsModel);

}
class GetCategoryDetailsError extends CategoriesState {
  final String error;

  GetCategoryDetailsError(this.error);

}
