part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoaded extends AuthState {
  final UserEntity user;
  const AuthLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailed extends AuthState {
  final String errorMessage;
  const AuthFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
