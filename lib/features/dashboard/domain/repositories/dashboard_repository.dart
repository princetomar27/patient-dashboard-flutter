import '../entities/patient_entity.dart';

abstract class DashboardRepository {
  Future<PatientEntity?> getPatientInfo();
}
