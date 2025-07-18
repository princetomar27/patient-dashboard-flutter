import '../../domain/entities/billing_status_enum.dart';
import '../../domain/entities/user_status_enum.dart';
import '../models/patient_model.dart';
import 'dashboard_datasource.dart';

class DashboardLocalDataSource implements DashboardDataSource {
  @override
  Future<PatientModel?> getPatientInfo() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock patient data with dynamic delivery date for testing
    final now = DateTime.now();
    final deliveryDate = now.add(const Duration(days: 2)); // 2 days from now

    return PatientModel(
      fullName: 'Sarah Johnson',
      patientId: 'PAT-2024-001',
      currentPlan: 'Premium Care Plan',
      nextDeliveryDate: deliveryDate,
      remainingMedication: 12,
      status: UserStatusExtension.fromUserStatus('active'),
      billingStatus: BillingStatusExtension.fromBillingStatus('ok'),
    );
  }
}
