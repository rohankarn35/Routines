import 'package:fpdart/src/either.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/core/usecase/usecase.dart';
import 'package:routines/features/main/domain/repository/main_repository.dart';

class GetFromHive implements StaticUseCase<List<Subject>, GetFromHiveParams> {
  final MainRepository mainRepository;
  const GetFromHive(this.mainRepository);
  @override
  Either<Failure, List<Subject>> call(GetFromHiveParams params) {
    return mainRepository.getDataFromHive(day: params.day);
  }
}

class GetFromHiveParams {
  final String day;

  GetFromHiveParams({
    required this.day,
  });
}
