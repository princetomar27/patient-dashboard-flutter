import '../entities/shipment_entity.dart';
import '../repositories/shipment_repository.dart';

class GetShipmentHistoryUseCase {
  final ShipmentRepository repository;

  GetShipmentHistoryUseCase(this.repository);

  Future<List<ShipmentEntity>> call() async {
    return await repository.getShipmentHistory();
  }
}
