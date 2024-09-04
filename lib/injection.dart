import 'package:alarm/alarm.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get_it/get_it.dart';
import 'package:routines/core/cubits/appUser/app_user_cubit.dart';
import 'package:routines/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:routines/features/auth/data/repository/auth_repository_impl.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';
import 'package:routines/features/auth/domain/usecases/allDetails.dart';
import 'package:routines/features/auth/domain/usecases/branchDetails_usecase.dart';
import 'package:routines/features/auth/domain/usecases/checkUser.dart';
import 'package:routines/features/auth/domain/usecases/configRoutines.dart';
import 'package:routines/features/auth/domain/usecases/getElectiveSubjects_Usecase.dart';
import 'package:routines/features/auth/domain/usecases/saveUser_usecase.dart';
import 'package:routines/features/auth/domain/usecases/teacherCombineUseCase.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/main/data/datasource/main_local_data_source.dart';
import 'package:routines/features/main/data/datasource/main_remote_data_source.dart';
import 'package:routines/features/main/data/repository/main_repository_impl.dart';
import 'package:routines/features/main/domain/repository/main_repository.dart';
import 'package:routines/features/main/domain/usecases/delete_from_hive.dart';
import 'package:routines/features/main/domain/usecases/get_from_hive.dart';
import 'package:routines/features/main/domain/usecases/update_hive_data.dart';
import 'package:routines/features/main/domain/usecases/upload_to_hive.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initMain();

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Registering Use Cases
    ..registerLazySingleton(
      () => AllDetails(serviceLocator()),
    )
    ..registerLazySingleton(
      () => BranchDetails(serviceLocator()),
    )
    ..registerLazySingleton(
      () => GetelectivesubjectsUsecase(serviceLocator()),
    )
    ..registerLazySingleton(
      () => Configroutines(serviceLocator()),
    )
    ..registerLazySingleton(
      () => Teachercombineusecase(serviceLocator()),
    )
    ..registerLazySingleton(
      () => SaveuserUsecase(serviceLocator()),
    )
    ..registerLazySingleton(
      () => GetCurrentUserUsecase(serviceLocator()),
    )
    // Registering Bloc
    ..registerFactory(
      () => AuthBloc(
        allDetails: serviceLocator(),
        branchDetails: serviceLocator(),
        getelectivesubjectsUsecase: serviceLocator(),
        appUserCubit: serviceLocator(),
        configroutines: serviceLocator(),
        teachercombineusecase: serviceLocator(),
        saveuserUsecase: serviceLocator(),
        getCurrentUserUsecase: serviceLocator(),
      ),
    );
}

void _initMain() {
  serviceLocator.registerLazySingleton<MainLocalDataSource>(
      () => MainLocalDataSourceImpl());
  serviceLocator.registerLazySingleton<MainRepository>(
      () => MainRepositoryImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateHiveData(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UploadToHive(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetFromHive(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteFromHive(serviceLocator()));
  serviceLocator.registerFactory(() => RoutineBloc(
        updateHiveData: serviceLocator(),
        uploadToHive: serviceLocator(),
        getFromHive: serviceLocator(),
      ));
}
