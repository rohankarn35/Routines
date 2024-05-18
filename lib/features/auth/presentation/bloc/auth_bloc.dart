import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/domain/usecases/allDetails.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AllDetails _allDetails;
  AuthBloc({
    required AllDetails allDetails,
  })  : _allDetails = allDetails,
        super(AuthInitial()) {
    on<AuthSetupButtonClicked>((event, emit) async {
      emit(AuthLoading());

      final res = await _allDetails(const NoParams());
     
      res.fold(
        (l) => emit(AuthFailure("Something Went Wrong")),
        (r) => emit(
          AuthSucess(r),
        ),
      );
    });
  }
}
