import 'package:routines/features/auth/domain/entities/elective_model_entity.dart';

class ElectiveModel extends ElectiveModelEntity {
  ElectiveModel({required super.electiveSubjects});

  factory ElectiveModel.fromJson(
      {required Map<String, dynamic> json,
      required String year,
      required String branch,
      required String elective}) {
    return ElectiveModel(
        electiveSubjects: json[year][branch]["sub"]["elective"][elective]);
  }
}
