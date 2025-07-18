import '../../domain/entities/shipment_entity.dart';
import '../../domain/entities/shipment_status_enum.dart';

class ShipmentModel extends ShipmentEntity {
  const ShipmentModel({
    required super.id,
    required super.medicationName,
    required super.medicationDosage,
    required super.doses,
    required super.deliveryDate,
    required super.status,
    required super.trackingNumber,
    required super.deliveryAddress,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'],
      medicationName: json['medicationName'],
      medicationDosage: json['medicationDosage'],
      doses: json['doses'],
      deliveryDate: DateTime.parse(json['deliveryDate']),
      status: ShipmentStatus.values.byName(json['status']),
      trackingNumber: json['trackingNumber'],
      deliveryAddress: json['deliveryAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicationName': medicationName,
      'medicationDosage': medicationDosage,
      'doses': doses,
      'deliveryDate': deliveryDate.toIso8601String(),
      'status': status.name,
      'trackingNumber': trackingNumber,
      'deliveryAddress': deliveryAddress,
    };
  }
}
