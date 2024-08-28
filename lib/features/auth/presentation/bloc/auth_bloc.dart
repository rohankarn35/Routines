import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/core/cubits/appUser/app_user_cubit.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';
import 'package:routines/features/auth/domain/usecases/allDetails.dart';
import 'package:routines/features/auth/domain/usecases/branchDetails_usecase.dart';
import 'package:routines/features/auth/domain/usecases/checkUser.dart';
import 'package:routines/features/auth/domain/usecases/configRoutines.dart';
import 'package:routines/features/auth/domain/usecases/getElectiveSubjects_Usecase.dart';
import 'package:routines/features/auth/domain/usecases/saveUser_usecase.dart';
import 'package:routines/features/auth/domain/usecases/teacherCombineUseCase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AllDetails _allDetails;
  final BranchDetails _branchDetails;
  final GetelectivesubjectsUsecase _getelectivesubjectsUsecase;
  final AppUserCubit _appUserCubit;
  final Configroutines _configroutines;
  final Teachercombineusecase _teachercombineusecase;
  final SaveuserUsecase _saveuserUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;

  AuthBloc(
      {required AllDetails allDetails,
      required BranchDetails branchDetails,
      required GetelectivesubjectsUsecase getelectivesubjectsUsecase,
      required AppUserCubit appUserCubit,
      required Configroutines configroutines,
      required Teachercombineusecase teachercombineusecase,
      required SaveuserUsecase saveuserUsecase,
      required GetCurrentUserUsecase getCurrentUserUsecase})
      : _allDetails = allDetails,
        _branchDetails = branchDetails,
        _getelectivesubjectsUsecase = getelectivesubjectsUsecase,
        _appUserCubit = appUserCubit,
        _configroutines = configroutines,
        _teachercombineusecase = teachercombineusecase,
        _getCurrentUserUsecase = getCurrentUserUsecase,
        _saveuserUsecase = saveuserUsecase,
        super(AuthInitial()) {
    // Registering the event handlers
    on<AuthSetupButtonClicked>(_onAuthSetupButtonClicked);
    on<AuthYearButtonClicked>(_onAuthYearButtonClicked);
    on<AuthBranchClicked>(_onAuthBranchClicked);
    on<AuthButtonSelectionGroupSelected>(_onAuthButtonSelectionGroupSelected);
    on<AuthButtonSelectIsWrapEvent>(_onAuthButtonSelectIsWrapEvent);
    on<AuthBranchAndYearSelectedEvent>(_onAuthBranchAndYearSelectedEvent);
    on<AuthSectionNameSelectedEvent>(_onAuthSectionNameSelectedEvent);
    on<AuthCoreSectionDetailsEvent>(_onAuthCoreSectionDetailsEvent);
    on<AuthElectiveSectionDetailsEvent>(_onAuthElectiveSectionDetailsEvent);
    on<AuthGetElectiveSubjectsEvent>(_onAuthGetElectiveSubjectsEvent);
    on<AuthConfigRoutinesEvent>(_onAuthConfigRoutinesEvent);
    on<AuthTeacherCombineEvent>(_onAuthTeacherCombineEvent);
    on<AuthSaveUserEvent>(_onSaveUser);
    on<AuthCheckUserEvent>(_oncheckUser);
  }

  Future<void> _onAuthSetupButtonClicked(
      AuthSetupButtonClicked event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _allDetails(const NoParams());
    res.fold(
      (l) => emit(AuthFailure("Something Went Wrong")),
      (r) => emit(AuthSucess(r)),
    );
  }

  void _onAuthYearButtonClicked(
      AuthYearButtonClicked event, Emitter<AuthState> emit) {
    emit(AuthYearButton(year: event.year));
  }

  void _onAuthBranchClicked(AuthBranchClicked event, Emitter<AuthState> emit) {
    emit(AuthBranchButton(branch: event.branch));
  }

  void _onAuthButtonSelectionGroupSelected(
      AuthButtonSelectionGroupSelected event, Emitter<AuthState> emit) {
    emit(AuthButtonGroupSelected(title: event.title));
  }

  void _onAuthButtonSelectIsWrapEvent(
      AuthButtonSelectIsWrapEvent event, Emitter<AuthState> emit) {
    emit(AuthButtonSelectIsWrapState(isWrap: event.isWrap));
  }

  Future<void> _onAuthBranchAndYearSelectedEvent(
      AuthBranchAndYearSelectedEvent event, Emitter<AuthState> emit) async {
    final numbers = await _branchDetails(
        BranchDetailsParams(year: event.year, branch: event.branch));
    numbers.fold(
      (l) => emit(AuthFailure("Something went wrong")),
      (r) => emit(AuthBranchAndYearSelectedState(numbers: r)),
    );
  }

  void _onAuthSectionNameSelectedEvent(
      AuthSectionNameSelectedEvent event, Emitter<AuthState> emit) {
    emit(AuthSectionNameSelectedState(sectionName: event.sectionName));
  }

  void _onAuthCoreSectionDetailsEvent(
      AuthCoreSectionDetailsEvent event, Emitter<AuthState> emit) {
    emit(AuthCoreSectionDetailsState(coreSection: event.coreSection));
  }

  void _onAuthElectiveSectionDetailsEvent(
      AuthElectiveSectionDetailsEvent event, Emitter<AuthState> emit) {
    emit(AuthElectiveSectionDetailsState(electiveList: event.electiveDetails));
  }

  Future<void> _onAuthGetElectiveSubjectsEvent(
      AuthGetElectiveSubjectsEvent event, Emitter<AuthState> emit) async {
    final res = await _getelectivesubjectsUsecase(GetelectivesubjectsParams(
        year: event.year, branch: event.branch, elective: event.elective));
    res.fold(
      (l) => emit(AuthFailure("An error occurred, Please try again")),
      (r) => emit(AuthGetElectiveSubjectsState(electiveDetails: r)),
    );
  }

  Future<void> _onAuthConfigRoutinesEvent(
      AuthConfigRoutinesEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _configroutines(ConfigRoutinesParams(
      year: event.year,
      coreSection: event.coreSection,
      electiveSections: event.electiveSections,
    ));
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthConfigRoutinesState(routineDetails: r)),
    );
  }

  Future<void> _onAuthTeacherCombineEvent(
      AuthTeacherCombineEvent event, Emitter<AuthState> emit) async {
    final res = await _teachercombineusecase(TeacherCombineParams(
      year: event.year,
      branch: event.branch,
      coreSection: event.coreSection,
      electiveList: event.electiveList,
    ));
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthTeacherCombineState(teacherCombinedDetails: r)),
    );
  }

  Future<void> _onSaveUser(
      AuthSaveUserEvent event, Emitter<AuthState> emit) async {
    final _res = await _saveuserUsecase(SaveuserParams(
        year: event.year,
        branch: event.branch,
        coreSection: event.coreSection,
        electiveSections: event.electiveList));
    _res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitUserSuccess(r, emit));
  }

  Future<void> _oncheckUser(
      AuthCheckUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthUserLoadingState());
    final _res = await _getCurrentUserUsecase(NoUserParams());

    _res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitUserSuccess(r, emit));
  }

  void _emitUserSuccess(
    Userentity? user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthUserSuccessState());
  }
}
