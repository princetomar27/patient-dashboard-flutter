import '../../domain/entities/shipment_status_enum.dart';
import '../models/shipment_model.dart';
import 'shipment_datasource.dart';

class ShipmentLocalDataSource implements ShipmentDataSource {
  @override
  Future<List<ShipmentModel>> getShipmentHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock shipment data
    return [
      ShipmentModel(
        id: '1',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2024, 1, 22),
        status: ShipmentStatus.shipped,
        trackingNumber: 'TRK999888777',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
      ShipmentModel(
        id: '2',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2024, 1, 15),
        status: ShipmentStatus.delivered,
        trackingNumber: 'TRK123456789',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
      ShipmentModel(
        id: '3',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2023, 12, 18),
        status: ShipmentStatus.delivered,
        trackingNumber: 'TRK987654321',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
      ShipmentModel(
        id: '4',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2023, 11, 20),
        status: ShipmentStatus.delivered,
        trackingNumber: 'TRK456789123',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
      ShipmentModel(
        id: '5',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2023, 10, 22),
        status: ShipmentStatus.delivered,
        trackingNumber: 'TRK789123456',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
      ShipmentModel(
        id: '6',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2023, 9, 25),
        status: ShipmentStatus.delivered,
        trackingNumber: 'TRK321654987',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
      ShipmentModel(
        id: '7',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2023, 8, 28),
        status: ShipmentStatus.delivered,
        trackingNumber: 'TRK654987321',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
      ShipmentModel(
        id: '8',
        medicationName: 'Lisinopril',
        medicationDosage: '10mg',
        doses: 30,
        deliveryDate: DateTime(2023, 7, 30),
        status: ShipmentStatus.delivered,
        trackingNumber: 'TRK147258369',
        deliveryAddress: '123 Main St, Springfield, IL 62701',
      ),
    ];
  }

  @override
  Future<ShipmentModel?> getShipmentDetails(String shipmentId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Get shipment from the list
    final shipments = await getShipmentHistory();
    return shipments.firstWhere((shipment) => shipment.id == shipmentId);
  }
}
