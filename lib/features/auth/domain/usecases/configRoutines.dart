import 'package:fpdart/src/either.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class Configroutines
    implements UseCase<Map<String, dynamic>, ConfigRoutinesParams> {
  final AuthRepository authRepository;
  const Configroutines(this.authRepository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      ConfigRoutinesParams params) {
    return authRepository.configRoutines(
        year: params.year,
        coreSection: params.coreSection,
        electiveSections: params.electiveSections);
  }
}

class ConfigRoutinesParams {
  final String year;
  final String coreSection;
  final List<String> electiveSections;

  ConfigRoutinesParams({
    required this.year,
    required this.coreSection,
    required this.electiveSections,
  });
}
