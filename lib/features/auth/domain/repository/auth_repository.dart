import 'package:fpdart/fpdart.dart';
import 'package:routines/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, List<int>>> branchDetails({
    required String year,
    required String branch,
  });

  Future<Either<Failure, Map<String, dynamic>>> getElectiveSubjectDetails(
      {required String year, required String branch, required String elective});
  Future<Either<Failure, String>> getAllDetails();
}
