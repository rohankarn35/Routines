import 'package:fpdart/fpdart.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class BranchDetails implements UseCase<String, BranchDetailsParams> {
  final AuthRepository authRepository;
  const BranchDetails(this.authRepository);
  @override
  Future<Either<Failure, String>> call(BranchDetailsParams params) async {
    return await authRepository.branchDetails(
      year: params.year,
      branch: params.branch,
    );
  }
}

class BranchDetailsParams {
  final String year;
  final String branch;

  BranchDetailsParams({
    required this.year,
    required this.branch,
  });
}
