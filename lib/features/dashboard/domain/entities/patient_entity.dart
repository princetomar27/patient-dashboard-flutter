import 'package:equatable/equatable.dart';

import 'billing_status_enum.dart';
import 'user_status_enum.dart';

class PatientEntity extends Equatable {
  final String fullName;
  final String patientId;
  final String currentPlan;
  final DateTime nextDeliveryDate;
  final num remainingMedication;
  final UserStatus status;
  final BillingStatus billingStatus;

  const PatientEntity({
    required this.fullName,
    required this.patientId,
    required this.currentPlan,
    required this.nextDeliveryDate,
    required this.remainingMedication,
    required this.status,
    required this.billingStatus,
  });

  @override
  List<Object?> get props => [
    fullName,
    patientId,
    currentPlan,
    nextDeliveryDate,
    remainingMedication,
    status,
    billingStatus,
  ];
}
