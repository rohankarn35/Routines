part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucess extends AuthState {
  final String data;
  AuthSucess(this.data);
}

final class AuthFailure extends AuthState {
  final String failureText;
  AuthFailure(this.failureText);
}

final class AuthYearButton extends AuthState {
  final String year;

  AuthYearButton({required this.year});
}

final class AuthBranchButton extends AuthState {
  final String branch;

  AuthBranchButton({required this.branch});
}

final class AuthButtonGroupSelected extends AuthState {
  final String title;

  AuthButtonGroupSelected({required this.title});
}

final class AuthButtonSelectIsWrapState extends AuthState {
  final bool isWrap;

  AuthButtonSelectIsWrapState({required this.isWrap});
}

final class AuthBranchAndYearSelectedState extends AuthState {
  final List<int> numbers;

  AuthBranchAndYearSelectedState({required this.numbers});
}

final class AuthSectionNameSelectedState extends AuthState {
  final String? sectionName;

  AuthSectionNameSelectedState({required this.sectionName});
}

final class AuthGetElectiveSubjectsState extends AuthState {
  final Map<String, dynamic> electiveDetails;

  AuthGetElectiveSubjectsState({required this.electiveDetails});
}

final class AuthCoreSectionDetailsState extends AuthState {
  final String coreSection;

  AuthCoreSectionDetailsState({required this.coreSection});
}

final class AuthElectiveSectionDetailsState extends AuthState {
  final Map<String, dynamic> electiveList;

  AuthElectiveSectionDetailsState({required this.electiveList});
}

final class AuthConfigRoutinesState extends AuthState {
  final Map<String, dynamic> routineDetails;

  AuthConfigRoutinesState({required this.routineDetails});
}

final class AuthTeacherCombineState extends AuthState {
  final Map<String, dynamic> teacherCombinedDetails;

  AuthTeacherCombineState({required this.teacherCombinedDetails});
}

final class AuthUserSuccessState extends AuthState {}
