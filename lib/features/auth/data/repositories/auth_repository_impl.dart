import 'package:patient_dashboard/features/auth/data/models/user_model.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<UserEntity?> login({
    required String email,
    required String password,
  }) async {
    final user = await datasource.login(email: email, password: password);
    return user;
  }

  @override
  Future<void> saveLoginInfo(bool isLoggedIn, UserEntity? user) async {
    await datasource.saveLoginInfo(
      isLoggedIn,
      user != null ? UserModel.fromEntity(user) : null,
    );
  }

  @override
  Future<bool> checkLoginStatus() async {
    return await datasource.checkLoginStatus();
  }

  @override
  Future<UserEntity?> getUser() async {
    final userModel = await datasource.getUser();
    return userModel;
  }
}
