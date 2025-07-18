import 'package:get_it/get_it.dart';

import '../features/auth/data/datasources/auth_datasource.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/check_login_status_usecase.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/save_login_status_usecase.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/dashboard/data/datasources/dashboard_datasource.dart';
import '../features/dashboard/data/datasources/dashboard_local_datasource.dart';
import '../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../features/dashboard/domain/usecases/get_patient_info_usecase.dart';
import '../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/shipment_history/data/datasources/shipment_datasource.dart';
import '../features/shipment_history/data/datasources/shipment_local_datasource.dart';
import '../features/shipment_history/data/repositories/shipment_repository_impl.dart';
import '../features/shipment_history/domain/repositories/shipment_repository.dart';
import '../features/shipment_history/domain/usecases/get_shipment_details_usecase.dart';
import '../features/shipment_history/domain/usecases/get_shipment_history_usecase.dart';
import '../features/shipment_history/presentation/cubit/shipment_history/shipment_history_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Auth dependencies
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

  // Dashboard dependencies
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSource(),
  );
  sl.registerLazySingleton<DashboardDataSource>(
    () => DashboardDataSourceImpl(
      localDataSource: sl<DashboardLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      localDataSource: sl<DashboardLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<GetPatientInfoUseCase>(
    () => GetPatientInfoUseCase(sl<DashboardRepository>()),
  );
  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(sl<GetPatientInfoUseCase>()),
  );

  // Home dependencies
  sl.registerFactory<HomeCubit>(() => HomeCubit());

  // Shipment History dependencies
  sl.registerLazySingleton<ShipmentLocalDataSource>(
    () => ShipmentLocalDataSource(),
  );
  sl.registerLazySingleton<ShipmentDataSource>(() => ShipmentLocalDataSource());
  sl.registerLazySingleton<ShipmentRepository>(
    () => ShipmentRepositoryImpl(dataSource: sl<ShipmentDataSource>()),
  );
  sl.registerLazySingleton<GetShipmentHistoryUseCase>(
    () => GetShipmentHistoryUseCase(sl<ShipmentRepository>()),
  );
  sl.registerLazySingleton<GetShipmentDetailsUseCase>(
    () => GetShipmentDetailsUseCase(sl<ShipmentRepository>()),
  );
  sl.registerFactory<ShipmentCubit>(
    () => ShipmentCubit(
      getShipmentHistoryUseCase: sl<GetShipmentHistoryUseCase>(),
      getShipmentDetailsUseCase: sl<GetShipmentDetailsUseCase>(),
    ),
  );
}
