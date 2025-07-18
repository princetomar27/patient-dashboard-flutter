import '../entities/shipment_entity.dart';
import '../repositories/shipment_repository.dart';

class GetShipmentDetailsUseCase {
  final ShipmentRepository repository;

  GetShipmentDetailsUseCase(this.repository);

  Future<ShipmentEntity?> call(String shipmentId) async {
    return await repository.getShipmentDetails(shipmentId);
  }
}
