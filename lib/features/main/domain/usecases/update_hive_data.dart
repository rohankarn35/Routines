import 'package:fpdart/src/either.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/main/domain/repository/main_repository.dart';

class UpdateHiveData implements StaticUseCase<void, UpdateHiveDataParams> {
  final MainRepository mainRepository;
  const UpdateHiveData(this.mainRepository);

  @override
  Either<Failure, void> call(UpdateHiveDataParams params) {
    return mainRepository.updateHiveData(
      subject: params.subject,
      index: params.index,
      day: params.day,
    );
  }
}

class UpdateHiveDataParams {
  final Subject subject;
  final int index;
  final String day;

  UpdateHiveDataParams({
    required this.subject,
    required this.index,
    required this.day,
  });
}
