import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/domain/usecases/allDetails.dart';
import 'package:routines/features/auth/domain/usecases/branchDetails_usecase.dart';
import 'package:routines/features/auth/domain/usecases/getElectiveSubjects_Usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AllDetails _allDetails;
  final BranchDetails _branchDetails;
  final GetelectivesubjectsUsecase _getelectivesubjectsUsecase;
  AuthBloc({
    required AllDetails allDetails,
    required BranchDetails branchDetails,
    required GetelectivesubjectsUsecase getelectivesubjectsUsecase,
  })  : _allDetails = allDetails,
        _branchDetails = branchDetails,
        _getelectivesubjectsUsecase = getelectivesubjectsUsecase,
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
      final numbers = await _branchDetails(
          BranchDetailsParams(year: event.year, branch: event.branch));

      numbers.fold((l) => emit(AuthFailure("Something went wrong")),
          (r) => emit(AuthBranchAndYearSelectedState(numbers: r)));
    });
    on<AuthSectionNameSelectedEvent>((event, emit) {
      emit(AuthSectionNameSelectedState(sectionName: event.sectionName));
    });
    on<AuthCoreSectionDetailsEvent>((event, emit) {
      emit(AuthCoreSectionDetailsState(coreSection: event.coreSection));
    });
    on<AuthElectiveSectionDetailsEvent>((event, emit) {
      emit(
          AuthElectiveSectionDetailsState(electiveList: event.electiveDetails));
    });

    on<AuthGetElectiveSubjectsEvent>((event, emit) async {
      final res = await _getelectivesubjectsUsecase(GetelectivesubjectsParams(
          year: event.year, branch: event.branch, elective: event.elective));
      res.fold((l) => emit(AuthFailure("An error occured, Please try again")),
          (r) => emit(AuthGetElectiveSubjectsState(electiveDetails: r)));
    });
  }
}
