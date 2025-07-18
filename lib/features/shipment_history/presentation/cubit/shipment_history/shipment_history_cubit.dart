import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/shipment_entity.dart';
import '../../../domain/usecases/get_shipment_details_usecase.dart';
import '../../../domain/usecases/get_shipment_history_usecase.dart';

part 'shipment_history_state.dart';

class ShipmentCubit extends Cubit<ShipmentState> {
  final GetShipmentHistoryUseCase getShipmentHistoryUseCase;
  final GetShipmentDetailsUseCase getShipmentDetailsUseCase;

  ShipmentCubit({
    required this.getShipmentHistoryUseCase,
    required this.getShipmentDetailsUseCase,
  }) : super(const ShipmentInitial()) {
    _initialize();
  }

  void _initialize() {
    loadShipmentHistory();
  }

  Future<void> loadShipmentHistory() async {
    emit(const ShipmentLoading());
    try {
      final shipments = await getShipmentHistoryUseCase();
      emit(ShipmentHistoryLoaded(shipments));
    } catch (e) {
      emit(ShipmentFailed(e.toString()));
    }
  }
}
