part of 'shipment_details_cubit.dart';

abstract class ShipmentDetailsState extends Equatable {
  const ShipmentDetailsState();

  @override
  List<Object?> get props => [];
}

class ShipmentDetailsInitial extends ShipmentDetailsState {
  const ShipmentDetailsInitial();
}

class ShipmentDetailsLoading extends ShipmentDetailsState {
  const ShipmentDetailsLoading();
}

class ShipmentDetailsLoaded extends ShipmentDetailsState {
  final ShipmentEntity shipment;

  const ShipmentDetailsLoaded(this.shipment);

  @override
  List<Object?> get props => [shipment];
}

class ShipmentDetailsFailed extends ShipmentDetailsState {
  final String errorMessage;

  const ShipmentDetailsFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
