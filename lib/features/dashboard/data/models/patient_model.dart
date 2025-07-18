import '../../domain/entities/billing_status_enum.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/user_status_enum.dart';

class PatientModel extends PatientEntity {
  const PatientModel({
    required super.fullName,
    required super.patientId,
    required super.currentPlan,
    required super.nextDeliveryDate,
    required super.remainingMedication,
    required super.status,
    required super.billingStatus,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      fullName: json['fullName'],
      patientId: json['patientId'],
      currentPlan: json['currentPlan'],
      nextDeliveryDate: DateTime.parse(json['nextDeliveryDate']),
      remainingMedication: json['remainingMedication'],
      status: UserStatusExtension.fromUserStatus(json['status']),
      billingStatus: BillingStatusExtension.fromBillingStatus(
        json['billingStatus'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'patientId': patientId,
      'currentPlan': currentPlan,
      'nextDeliveryDate': nextDeliveryDate.toIso8601String(),
      'remainingMedication': remainingMedication,
      'status': status,
      'billingStatus': billingStatus,
    };
  }
}
