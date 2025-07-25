import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String password;

  const UserEntity({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
