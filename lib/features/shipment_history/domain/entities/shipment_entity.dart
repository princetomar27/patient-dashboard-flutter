import 'package:equatable/equatable.dart';

import 'shipment_status_enum.dart';

class ShipmentEntity extends Equatable {
  final String id;
  final String medicationName;
  final String medicationDosage;
  final int doses;
  final DateTime deliveryDate;
  final ShipmentStatus status;
  final String trackingNumber;
  final String deliveryAddress;

  const ShipmentEntity({
    required this.id,
    required this.medicationName,
    required this.medicationDosage,
    required this.doses,
    required this.deliveryDate,
    required this.status,
    required this.trackingNumber,
    required this.deliveryAddress,
  });

  @override
  List<Object?> get props => [
    id,
    medicationName,
    medicationDosage,
    doses,
    deliveryDate,
    status,
    trackingNumber,
    deliveryAddress,
  ];
}
