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
