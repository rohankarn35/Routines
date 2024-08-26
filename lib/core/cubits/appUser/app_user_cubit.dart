import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(Userentity? user) {
    if (user == null || user.branch == null || user.year == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
