import 'package:get_it/get_it.dart';
import 'package:routines/core/cubits/appUser/app_user_cubit.dart';
import 'package:routines/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:routines/features/auth/data/repository/auth_repository_impl.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';
import 'package:routines/features/auth/domain/usecases/allDetails.dart';
import 'package:routines/features/auth/domain/usecases/branchDetails_usecase.dart';
import 'package:routines/features/auth/domain/usecases/configRoutines.dart';
import 'package:routines/features/auth/domain/usecases/getElectiveSubjects_Usecase.dart';
import 'package:routines/features/auth/domain/usecases/teacherCombineUseCase.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  _initAuth();
}

void _initAuth() {
  // Registering Data Source
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Registering Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  // Registering Use Cases
  serviceLocator.registerLazySingleton(
    () => AllDetails(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => BranchDetails(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetelectivesubjectsUsecase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(
    () => Configroutines(serviceLocator()),
  );
  serviceLocator
      .registerLazySingleton(() => Teachercombineusecase(serviceLocator()));

  // Registering Bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      allDetails: serviceLocator(),
      branchDetails: serviceLocator(),
      getelectivesubjectsUsecase: serviceLocator(),
      appUserCubit: serviceLocator(),
      configroutines: serviceLocator(),
      teachercombineusecase: serviceLocator(),
    ),
  );
}
