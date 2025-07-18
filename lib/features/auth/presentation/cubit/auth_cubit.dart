import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/check_login_status_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/save_login_status_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SaveLoginStatusUseCase saveLoginStatusUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;
  final AuthRepository authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();

  AuthCubit(
    this.loginUseCase,
    this.saveLoginStatusUseCase,
    this.checkLoginStatusUseCase,
    this.authRepository,
  ) : super(const AuthInitial()) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await checkLoginStatusUseCase();
    if (isLoggedIn) {
      final user = await authRepository.getUser();
      if (user != null) {
        emit(AuthLoaded(user));
        return;
      }
    }
    emit(const AuthInitial());
  }

  Future<void> login() async {
    emit(const AuthLoading());
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final user = await loginUseCase(email: email, password: password);
      if (user != null) {
        await saveLoginStatusUseCase(isLoggedIn: true, user: user);
        emit(AuthLoaded(user));
      } else {
        emit(const AuthFailed('Invalid credentials'));
      }
    }
  }

  Future<void> logout() async {
    await saveLoginStatusUseCase(isLoggedIn: false, user: null);
    emit(const AuthInitial());
  }

  String? Function(String?)? get emailValidator =>
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Email is required'),
        FormBuilderValidators.email(errorText: 'Please enter a valid email'),
      ]);

  String? Function(String?)? get passwordValidator =>
      FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Password is required'),
        FormBuilderValidators.minLength(
          6,
          errorText: 'Password must be at least 6 characters',
        ),
      ]);

  bool validateLogin() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
