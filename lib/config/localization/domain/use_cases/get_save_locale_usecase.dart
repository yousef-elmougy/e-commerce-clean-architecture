import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/locale_repository_impl.dart';

class GetSavedLocaleUseCase{
  final  LocaleRepositoryImpl localeRepositoryImpl;

  GetSavedLocaleUseCase({required this.localeRepositoryImpl});

  Future<Either<Failure,String>> call()async => await localeRepositoryImpl.getSaveLocale();

}