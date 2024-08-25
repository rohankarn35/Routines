// ignore_for_file: public_member_api_docs, sort_constructors_first

class SubjectModel {
  String subject;
  String time;
  String roomNo;
  bool isUserAdded;
  SubjectModel({
    required this.subject,
    required this.time,
    required this.roomNo,
    required this.isUserAdded,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subject: json['subject'],
      time: json['time'],
      roomNo: json['roomNo'],
      isUserAdded: json['isUserAdded'] ?? false,
    );
  }
}
