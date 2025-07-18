import '../models/shipment_model.dart';

abstract class ShipmentDataSource {
  Future<List<ShipmentModel>> getShipmentHistory();
  Future<ShipmentModel?> getShipmentDetails(String shipmentId);
}
