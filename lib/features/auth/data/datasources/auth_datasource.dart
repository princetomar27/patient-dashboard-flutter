import '../models/user_model.dart';
import 'auth_local_datasource.dart';

abstract class AuthDatasource {
  Future<UserModel?> login({required String email, required String password});
  Future<void> saveLoginInfo(bool isLoggedIn, UserModel? user);
  Future<bool> checkLoginStatus();
  Future<UserModel?> getUser();
}

class AuthDatasourceImpl implements AuthDatasource {
  final AuthLocalDataSource localDatasource;

  AuthDatasourceImpl({required this.localDatasource});

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    // TODO: replace localDatasource with remote datasource
    return localDatasource.login(email: email, password: password);
  }

  @override
  Future<void> saveLoginInfo(bool isLoggedIn, UserModel? user) async {
    await localDatasource.saveLoginInfo(isLoggedIn, user);
  }

  @override
  Future<bool> checkLoginStatus() async {
    return await localDatasource.checkLoginStatus();
  }

  @override
  Future<UserModel?> getUser() async {
    return await localDatasource.getUser();
  }
}
