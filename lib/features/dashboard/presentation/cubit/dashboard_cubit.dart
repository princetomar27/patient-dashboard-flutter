import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_patient_info_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetPatientInfoUseCase getPatientInfoUseCase;

  DashboardCubit(this.getPatientInfoUseCase) : super(const DashboardInitial()) {
    _initialize();
  }

  void _initialize() {
    loadPatientInfo();
  }

  Future<void> loadPatientInfo() async {
    emit(const DashboardLoading());
    try {
      final patient = await getPatientInfoUseCase();
      if (patient != null) {
        emit(DashboardLoaded(patient));
      } else {
        emit(const DashboardFailed('Failed to load patient information'));
      }
    } catch (e) {
      emit(DashboardFailed(e.toString()));
    }
  }
}
