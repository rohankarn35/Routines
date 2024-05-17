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
  final  String failureText;
  AuthFailure(this.failureText);
}
