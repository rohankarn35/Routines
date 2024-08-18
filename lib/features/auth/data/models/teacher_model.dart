// ignore_for_file: public_member_api_docs, sort_constructors_first
class TeacherModel {
  Map<String, dynamic> teacherList;
  TeacherModel({
    required this.teacherList,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json, String year,
      String branch, String coreSection) {
    return TeacherModel(
        teacherList: json[year][branch]["sub"]["core"][coreSection]);
  }
}
