import 'package:equatable/equatable.dart';

import '../../domain/entities/patient_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final PatientEntity patient;

  const DashboardLoaded(this.patient);

  @override
  List<Object?> get props => [patient];
}

class DashboardFailed extends DashboardState {
  final String errorMessage;

  const DashboardFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
