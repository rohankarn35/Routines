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
  serviceLocator.registerFactory(() => RoutineBloc());
}
