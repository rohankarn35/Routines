import 'package:fpdart/src/either.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class GetelectivesubjectsParams {
  final String year;
  final String branch;
  final String elective;

  GetelectivesubjectsParams(
      {required this.year, required this.branch, required this.elective});
}

class GetelectivesubjectsUsecase
    implements UseCase<Map<String, dynamic>, GetelectivesubjectsParams> {
  final AuthRepository _authRepository;
  const GetelectivesubjectsUsecase(this._authRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      GetelectivesubjectsParams params) {
    return _authRepository.getElectiveSubjectDetails(
        year: params.year, branch: params.branch, elective: params.elective);
  }
}
