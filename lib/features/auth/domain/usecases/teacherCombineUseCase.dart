import 'package:fpdart/src/either.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class Teachercombineusecase
    implements UseCase<Map<String, dynamic>, TeacherCombineParams> {
  final AuthRepository _authRepository;
  const Teachercombineusecase(this._authRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      TeacherCombineParams params) {
    return _authRepository.combineTeacherDetails(
        year: params.year,
        branch: params.branch,
        coreSection: params.coreSection,
        electiveList: params.electiveList);
  }
}

class TeacherCombineParams {
  final String year;
  final String branch;
  final String coreSection;
  final List<String> electiveList;

  TeacherCombineParams({
    required this.year,
    required this.branch,
    required this.coreSection,
    required this.electiveList,
  });
}
