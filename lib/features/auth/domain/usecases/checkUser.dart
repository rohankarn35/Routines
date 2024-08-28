import 'package:fpdart/fpdart.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUsecase implements UseCase<Userentity?, NoUserParams> {
  final AuthRepository _authRepository;

  GetCurrentUserUsecase(this._authRepository);

  @override
  Future<Either<Failure, Userentity?>> call(NoUserParams params) {
    return _authRepository.currentUser();
  }
}

class NoUserParams {
  const NoUserParams();
}
