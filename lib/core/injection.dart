import 'package:get_it/get_it.dart';
import '../features/auth/data/datasources/auth_datasource.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/save_login_status_usecase.dart';
import '../features/auth/domain/usecases/check_login_status_usecase.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImpl(localDatasource: sl<AuthLocalDataSource>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(datasource: sl<AuthDatasource>()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SaveLoginStatusUseCase>(
    () => SaveLoginStatusUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<CheckLoginStatusUseCase>(
    () => CheckLoginStatusUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      sl<LoginUseCase>(),
      sl<SaveLoginStatusUseCase>(),
      sl<CheckLoginStatusUseCase>(),
      sl<AuthRepository>(),
    ),
  );
}
