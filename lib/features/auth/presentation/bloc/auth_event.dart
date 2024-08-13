part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSetupButtonClicked extends AuthEvent {}

final class AuthYearButtonClicked extends AuthEvent {
  final String year;

  AuthYearButtonClicked({required this.year});
}

final class AuthBranchClicked extends AuthEvent {
  final String branch;

  AuthBranchClicked({required this.branch});
}

final class AuthButtonSelectionGroupSelected extends AuthEvent {
  final String title;

  AuthButtonSelectionGroupSelected({required this.title});
}

final class AuthButtonSelectIsWrapEvent extends AuthEvent {
  final bool isWrap;

  AuthButtonSelectIsWrapEvent({required this.isWrap});
}

final class AuthBranchAndYearSelectedEvent extends AuthEvent {
  final String branch;
  final String year;
  AuthBranchAndYearSelectedEvent({required this.branch, required this.year});
}

final class AuthSectionNameSelectedEvent extends AuthEvent {
  final String? sectionName;

  AuthSectionNameSelectedEvent({required this.sectionName});
}

final class AuthGetElectiveSubjectsEvent extends AuthEvent {
  final String branch;
  final String year;
  final String elective;

  AuthGetElectiveSubjectsEvent(
      {required this.branch, required this.year, required this.elective});
}

final class AuthCoreSectionDetailsEvent extends AuthEvent {
  final String coreSection;

  AuthCoreSectionDetailsEvent({required this.coreSection});
}

final class AuthElectiveSectionDetailsEvent extends AuthEvent {
  final List<String> electiveDetails;

  AuthElectiveSectionDetailsEvent({required this.electiveDetails});
}

final class AuthConfigRoutinesEvent extends AuthEvent {
  final String year;
  final String coreSection;
  final List<String> electiveSections;

  AuthConfigRoutinesEvent(
      {required this.year,
      required this.coreSection,
      required this.electiveSections});
}
