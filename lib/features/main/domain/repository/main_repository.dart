import 'package:fpdart/fpdart.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/failure.dart';

abstract interface class MainRepository {
  Either<Failure, List<Subject>> getDataFromHive({
    required String day,
  });
  Either<Failure, void> uploadToHive({
    required Subject subject,
    required String day,
  });
  Either<Failure, void> deleteFromHive({
    required Subject subject,
    required String day,
  });
  Either<Failure, void> updateHiveData(
      {required Subject subject, required int index, required String day});
}
