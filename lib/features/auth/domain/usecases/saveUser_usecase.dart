import 'package:fpdart/fpdart.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class SaveuserUsecase implements UseCase<Userentity, SaveuserParams> {
  final AuthRepository _authRepository;

  const SaveuserUsecase(this._authRepository);

  @override
  Future<Either<Failure, Userentity>> call(SaveuserParams params) {
    return _authRepository.saveUser(
      year: params.year,
      branch: params.branch,
      coreSection: params.coreSection,
      electiveList: params.electiveSections,
    );
  }
}

class SaveuserParams {
  final String year;
  final String branch;
  final String coreSection;
  final List<String> electiveSections;

  SaveuserParams({
    required this.year,
    required this.branch,
    required this.coreSection,
    required this.electiveSections,
  });
}
