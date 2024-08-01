import 'package:routines/features/auth/domain/entities/section_number_entity.dart';

class SectionNumbersModel extends SectionNumber {
  SectionNumbersModel({required super.core, required super.elective});

  factory SectionNumbersModel.fromJson(
      Map<String, dynamic> json, String year, String branch) {
    return SectionNumbersModel(
      core: json[year][branch]["details"]["core"],
      elective: json[year][branch]["details"]["elective"],
    );
  }
}
