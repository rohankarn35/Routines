import 'package:fpdart/fpdart.dart';
import 'package:routines/core/error/exception.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, List<int>>> branchDetails({
    required String year,
    required String branch,
  }) async {
    try {
      final branchDetails = await authRemoteDataSource.branchDetails(
        year: year,
        branch: branch,
      );
      return Right(branchDetails);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getElectiveSubjectDetails(
      {required String year,
      required String branch,
      required String elective}) async {
    try {
      final getDetails = await authRemoteDataSource.getElectiveSubjectDetails(
          year: year, branch: branch, elective: elective);
      return Right(getDetails);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getAllDetails() async {
    try {
      final allDetails = await authRemoteDataSource.getAllDetails();
      return Right(allDetails);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
