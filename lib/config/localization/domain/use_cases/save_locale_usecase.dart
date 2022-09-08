import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/config/localization/data/locale_repository_impl.dart';
import '../../../../core/error/failures.dart';

class SaveLocaleUseCase {
  final LocaleRepositoryImpl localeRepositoryImpl;

  SaveLocaleUseCase({required this.localeRepositoryImpl});

  Future<Either<Failure, bool>> call({required String codeLange}) async =>
      await localeRepositoryImpl.saveLocale(codeLang:codeLange);

}