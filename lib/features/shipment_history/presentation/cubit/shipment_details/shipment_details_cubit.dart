import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/shipment_entity.dart';
import '../../../domain/usecases/get_shipment_details_usecase.dart';

part 'shipment_details_state.dart';

class ShipmentDetailsCubit extends Cubit<ShipmentDetailsState> {
  final String shipmentId;
  final GetShipmentDetailsUseCase getShipmentDetailsUseCase;

  ShipmentDetailsCubit({
    required this.getShipmentDetailsUseCase,
    required this.shipmentId,
  }) : super(const ShipmentDetailsInitial()) {
    _initialize();
  }

  void _initialize() {
    loadShipmentDetails(shipmentId: shipmentId);
  }

  Future<void> loadShipmentDetails({required String shipmentId}) async {
    emit(const ShipmentDetailsLoading());
    try {
      final shipment = await getShipmentDetailsUseCase(shipmentId);
      if (shipment != null) {
        emit(ShipmentDetailsLoaded(shipment));
      } else {
        emit(const ShipmentDetailsFailed('Shipment not found'));
      }
    } catch (e) {
      emit(ShipmentDetailsFailed(e.toString()));
    }
  }
}
