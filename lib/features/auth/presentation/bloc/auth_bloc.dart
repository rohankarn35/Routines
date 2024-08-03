import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/domain/usecases/allDetails.dart';
import 'package:routines/features/auth/domain/usecases/sectionNumber_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AllDetails _allDetails;
  final SectionnumberUsecase _sectionnumberUsecase;
  AuthBloc({
    required AllDetails allDetails,
    required SectionnumberUsecase sectionNumberUsecase,
  })  : _allDetails = allDetails,
        _sectionnumberUsecase = sectionNumberUsecase,
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
    on<AuthYearButtonClicked>((event, emit) {
      emit(AuthYearButton(year: event.year));
    });
    on<AuthBranchClicked>((event, emit) {
      emit(AuthBranchButton(branch: event.branch));
    });
    on<AuthButtonSelectionGroupSelected>((event, emit) {
      emit(AuthButtonGroupSelected(title: event.title));
    });
    on<AuthButtonSelectIsWrapEvent>((event, emit) {
      emit(AuthButtonSelectIsWrapState(isWrap: event.isWrap));
    });

    on<AuthBranchAndYearSelectedEvent>((event, emit) async {
      final numbers = await _sectionnumberUsecase(
          SectionnumberParams(year: event.year, branch: event.branch));

      numbers.fold((l) => emit(AuthFailure("Something Went Wrong")),
          (r) => emit(AuthBranchAndYearSelectedState(numbers: r)));
    });
    on<AuthSectionNameSelectedEvent>((event, emit) {
      emit(AuthSectionNameSelectedState(sectionName: event.sectionName));
    });
  }
}
