import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(Userentity? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
