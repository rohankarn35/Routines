import 'package:fpdart/src/either.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, String>> branchDetails({
    required String year,
    required String branch,
  }) {

    throw UnimplementedError();
  }
}
