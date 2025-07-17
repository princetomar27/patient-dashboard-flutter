import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.email, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(email: entity.email, password: entity.password);
  }
}
