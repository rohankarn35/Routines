import 'package:routines/features/auth/domain/entities/elective_model_entity.dart';

class ElectiveModel extends ElectiveModelEntity {
  ElectiveModel({required super.electiveSubjects});

  factory ElectiveModel.fromJson(
      {required Map<String, dynamic> json,
      required String year,
      required String branch,
      required String elective}) {
    if (year == "2nd Year") {
      year = "second";
    }
    if (year == "3rd Year") {
      year = "third";
    }

    return ElectiveModel(
        electiveSubjects: json[year][branch]["sub"]["elective"][elective]);
  }
}
