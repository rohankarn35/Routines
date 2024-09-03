import 'package:fpdart/src/either.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/main/domain/repository/main_repository.dart';

class DeleteFromHive implements StaticUseCase<void, DeleteFromHiveParams> {
  final MainRepository mainRepository;
  const DeleteFromHive(this.mainRepository);

  @override
  Either<Failure, void> call(DeleteFromHiveParams params) {
    return mainRepository.deleteFromHive(
        subject: params.subject, day: params.day);
  }
}

class DeleteFromHiveParams {
  final Subject subject;
  final String day;

  DeleteFromHiveParams({
    required this.subject,
    required this.day,
  });
}
