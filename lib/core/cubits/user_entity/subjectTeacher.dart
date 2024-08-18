class SubjectTeacherJson {
  Map<String, String> subjectTeachers;

  SubjectTeacherJson({required this.subjectTeachers});

  factory SubjectTeacherJson.fromJson(Map<String, dynamic> json) {
    return SubjectTeacherJson(subjectTeachers: Map<String, String>.from(json));
  }
}
