import 'package:get_it/get_it.dart';
import 'package:routines/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:routines/features/auth/data/repository/auth_repository_impl.dart';
import 'package:routines/features/auth/domain/repository/auth_repository.dart';
import 'package:routines/features/auth/domain/usecases/allDetails.dart';
import 'package:routines/features/auth/domain/usecases/sectionNumber_usecase.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  _initAuth();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => AllDetails(serviceLocator()),
  );
  serviceLocator.registerFactory(() => SectionnumberUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
        allDetails: serviceLocator(), sectionNumberUsecase: serviceLocator()),
  );
}
