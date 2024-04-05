import 'package:fpdart/fpdart.dart';
import 'package:routines/core/error/failure.dart';

abstract interface class AuthRepository {
 Future< Either<Failure, String>> branchDetails({
    required String year,
    required String branch,
  });

  Future<Either<Failure, List<String>>> getElectiveSubjectDetails({
    required String year,
    required String branch,
    
  });
  

}
