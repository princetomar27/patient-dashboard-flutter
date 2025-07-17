import 'package:patient_dashboard/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class SaveLoginStatusUseCase {
  final AuthRepository repository;

  SaveLoginStatusUseCase(this.repository);

  Future<void> call({
    required bool isLoggedIn,
    required UserEntity? user,
  }) async {
    await repository.saveLoginInfo(isLoggedIn, user);
  }
}
