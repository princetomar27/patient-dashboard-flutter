import '../entities/shipment_entity.dart';

abstract class ShipmentRepository {
  Future<List<ShipmentEntity>> getShipmentHistory();
  Future<ShipmentEntity?> getShipmentDetails(String shipmentId);
}
