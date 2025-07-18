import '../entities/patient_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetPatientInfoUseCase {
  final DashboardRepository repository;

  GetPatientInfoUseCase(this.repository);

  Future<PatientEntity?> call() async {
    return await repository.getPatientInfo();
  }
}
