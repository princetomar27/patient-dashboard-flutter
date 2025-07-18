import '../models/patient_model.dart';
import 'dashboard_local_datasource.dart';

abstract class DashboardDataSource {
  Future<PatientModel?> getPatientInfo();
}

class DashboardDataSourceImpl implements DashboardDataSource {
  final DashboardLocalDataSource localDataSource;

  DashboardDataSourceImpl({required this.localDataSource});

  @override
  Future<PatientModel?> getPatientInfo() async {
    // TODO: Remove this once we have a real datasource
    return await localDataSource.getPatientInfo();
  }
}
