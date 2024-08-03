import 'package:fpdart/src/either.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class SectionnumberUsecase implements UseCase<List<int>, SectionnumberParams> {
  final AuthRepository authRepository;
  const SectionnumberUsecase(this.authRepository);

  @override
  Future<Either<Failure, List<int>>> call(SectionnumberParams params) async {
    return await authRepository.branchDetails(
        year: params.year, branch: params.branch);
  }
}

class SectionnumberParams {
  final String year;
  final String branch;

  SectionnumberParams({required this.year, required this.branch});
}
