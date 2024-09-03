import 'package:fpdart/src/either.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/main/domain/repository/main_repository.dart';

class UploadToHive implements StaticUseCase<void, UploadToHiveParams> {
  final MainRepository mainRepository;
  const UploadToHive(this.mainRepository);

  @override
  Either<Failure, void> call(UploadToHiveParams params) {
    return mainRepository.uploadToHive(
        subject: params.subject, day: params.day);
  }
}

class UploadToHiveParams {
  final Subject subject;
  final String day;

  UploadToHiveParams({
    required this.subject,
    required this.day,
  });
}
