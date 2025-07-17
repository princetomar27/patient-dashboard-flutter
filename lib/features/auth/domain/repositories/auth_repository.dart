import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> login({required String email, required String password});
  Future<void> saveLoginInfo(bool isLoggedIn, UserEntity? user);
  Future<bool> checkLoginStatus();
  Future<UserEntity?> getUser();
}
