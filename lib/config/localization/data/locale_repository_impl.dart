import 'package:dartz/dartz.dart';
import 'package:shop_clean_architecture/core/network/network_info.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../domain/locale_repository.dart';
import 'locale_data_source.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleDataSourceImpl localeDataSourceImpl;
  final NetworkInfo networkInfo;

  LocaleRepositoryImpl(
      {required this.networkInfo, required this.localeDataSourceImpl});

  @override
  Future<Either<Failure, String>> getSaveLocale() async {
    if (await networkInfo.isConnected) {
      try {
      final getSavedLocal = await localeDataSourceImpl.getSaveLocale();
      return Right(getSavedLocal);
    } on CacheException {
      return Left(CacheFailure());
    }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveLocale({required String codeLang}) async {
    if (await networkInfo.isConnected) {
      try {
      final saveLocal = await localeDataSourceImpl.saveLocale(codeLang: codeLang);
      return Right(saveLocal);
    } on CacheException {
      return Left(CacheFailure());
    }
    }else{
      return Left(OfflineFailure());
    }
  }
}
