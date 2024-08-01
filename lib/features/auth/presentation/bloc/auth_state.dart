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
