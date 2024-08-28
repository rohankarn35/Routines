import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';
import 'package:routines/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, List<int>>> branchDetails({
    required String year,
    required String branch,
  });

  Future<Either<Failure, Map<String, dynamic>>> getElectiveSubjectDetails(
      {required String year, required String branch, required String elective});
  Future<Either<Failure, String>> getAllDetails();

  Future<Either<Failure, Map<String, dynamic>>> configRoutines({
    required final String year,
    required String coreSection,
    required List<String> electiveSections,
  });
  Future<Either<Failure, Map<String, dynamic>>> combineTeacherDetails(
      {required String year,
      required String branch,
      required String coreSection,
      required List<String> electiveList});
  Future<Either<Failure, Userentity>> saveUser(
      {required String year,
      required String branch,
      required String coreSection,
      required List<String> electiveList});

  Future<Either<Failure, Userentity?>> currentUser();
}
