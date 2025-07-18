part of 'shipment_history_cubit.dart';

abstract class ShipmentState extends Equatable {
  const ShipmentState();

  @override
  List<Object?> get props => [];
}

class ShipmentInitial extends ShipmentState {
  const ShipmentInitial();
}

class ShipmentLoading extends ShipmentState {
  const ShipmentLoading();
}

class ShipmentHistoryLoaded extends ShipmentState {
  final List<ShipmentEntity> shipments;

  const ShipmentHistoryLoaded(this.shipments);

  @override
  List<Object?> get props => [shipments];
}

class ShipmentDetailsLoading extends ShipmentState {
  const ShipmentDetailsLoading();
}

class ShipmentFailed extends ShipmentState {
  final String errorMessage;

  const ShipmentFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
