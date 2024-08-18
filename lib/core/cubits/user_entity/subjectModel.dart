// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubjectModel {
  String subject;
  String time;
  String roomNo;
  SubjectModel({
    required this.subject,
    required this.time,
    required this.roomNo,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subject: json['subject'],
      time: json['time'],
      roomNo: json['roomNo'],
    );
  }
}
