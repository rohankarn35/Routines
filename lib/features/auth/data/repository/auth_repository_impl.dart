import 'package:fpdart/fpdart.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> configRoutines({
    required final String year,
    required String coreSection,
    required List<String> electiveSections,
  }) async {
    try {
      final configRoutines = await authRemoteDataSource.configRoutines(
          coreSection: coreSection,
          electiveSections: electiveSections,
          year: year);
      return Right(configRoutines);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> combineTeacherDetails(
      {required String year,
      required String branch,
      required String coreSection,
      required List<String> electiveList}) async {
    try {
      final combineTeacherDetails =
          await authRemoteDataSource.combineTeacherDetails(
              year: year,
              branch: branch,
              coreSection: coreSection,
              electiveList: electiveList);
      return Right(combineTeacherDetails);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Userentity>> saveUser(
      {required String year,
      required String branch,
      required String coreSection,
      required List<String> electiveList}) async {
    try {
      final _saveUser = await authRemoteDataSource.saveUser(
          year: year,
          branch: branch,
          coreSection: coreSection,
          electiveList: electiveList);
      return Right(_saveUser);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Userentity>> currentUser() async {
    try {
      final _currentUser = await authRemoteDataSource.currentUser();
      return Right(_currentUser);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
