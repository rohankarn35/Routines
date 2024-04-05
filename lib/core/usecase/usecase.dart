import 'package:fpdart/fpdart.dart';
import 'package:routines/core/error/failure.dart';

abstract interface class UseCase<SucessType, Params >{
  Future<Either<Failure, SucessType>> call(Params params);
}