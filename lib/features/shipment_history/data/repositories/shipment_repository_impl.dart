import '../../domain/entities/shipment_entity.dart';
import '../../domain/repositories/shipment_repository.dart';
import '../datasources/shipment_datasource.dart';

class ShipmentRepositoryImpl implements ShipmentRepository {
  final ShipmentDataSource dataSource;

  ShipmentRepositoryImpl({required this.dataSource});

  @override
  Future<List<ShipmentEntity>> getShipmentHistory() async {
    final shipments = await dataSource.getShipmentHistory();
    return shipments;
  }

  @override
  Future<ShipmentEntity?> getShipmentDetails(String shipmentId) async {
    final shipment = await dataSource.getShipmentDetails(shipmentId);
    return shipment;
  }
}
