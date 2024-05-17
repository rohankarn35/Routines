import 'package:fpdart/src/either.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class AllDetails implements UseCase<String, NoParams> {
  final AuthRepository authRepository;
  const AllDetails(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.getAllDetails();
  }
}

class NoParams {
  const NoParams();
}
