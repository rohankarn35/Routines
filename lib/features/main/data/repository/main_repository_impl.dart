import 'package:fpdart/src/either.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/exception.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/features/main/data/datasource/main_local_data_source.dart';
import 'package:routines/features/main/domain/repository/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainLocalDataSource mainLocalDataSource;
  const MainRepositoryImpl(this.mainLocalDataSource);

  @override
  Either<Failure, void> deleteFromHive(
      {required Subject subject, required String day}) {
    try {
      final _data =
          mainLocalDataSource.deleteFromHive(subject: subject, day: day);

      return Right(_data);
    } on HiveDataException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Either<Failure, List<Subject>> getDataFromHive({required String day}) {
    try {
      final _data = mainLocalDataSource.getDataFromHive(day: day);
      return Right(_data);
    } on HiveDataException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Either<Failure, void> updateHiveData(
      {required Subject subject, required int index, required String day}) {
    try {
      final _data = mainLocalDataSource.updateHiveData(
          subject: subject, index: index, day: day);

      return Right(_data);
    } on HiveDataException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Either<Failure, void> uploadToHive(
      {required Subject subject, required String day}) {
    try {
      final _data =
          mainLocalDataSource.uploadToHive(subject: subject, day: day);

      return Right(_data);
    } on HiveDataException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
