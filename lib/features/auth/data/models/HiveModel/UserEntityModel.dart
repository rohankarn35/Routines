import 'package:hive/hive.dart';

part 'UserEntityModel.g.dart';

@HiveType(typeId: 3) // Ensure typeId is unique across your project
class Userentitymodel extends HiveObject {
  @HiveField(0)
  final String? year;

  @HiveField(1)
  final String? branch;

  @HiveField(2)
  final String? coreSection;

  @HiveField(3)
  final List<String>? electiveSections;

  Userentitymodel({
    required this.year,
    required this.branch,
    required this.coreSection,
    required this.electiveSections,
  });
}
