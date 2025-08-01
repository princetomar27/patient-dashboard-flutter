import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  final bool obscurePassword;
  final VoidCallback onTogglePassword;

  const LoginForm({
    super.key,
    required this.obscurePassword,
    required this.onTogglePassword,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _obscurePassword = widget.obscurePassword;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          context.go('/dashboard');
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        return FormBuilder(
          key: authCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF22223B),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Sign in to access your patient dashboard',
                  style: TextStyle(fontSize: 14, color: Color(0xFF4A4E69)),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Email Address',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A4E69),
                ),
              ),
              const SizedBox(height: 8),
              FormBuilderTextField(
                name: 'email',
                controller: authCubit.emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  filled: true,
                  fillColor: Color(0xFFFFFDE4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color(0xFF4A4E69),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: authCubit.emailValidator,
              ),
              const SizedBox(height: 16),
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A4E69),
                ),
              ),
              const SizedBox(height: 8),
              FormBuilderTextField(
                name: 'password',
                controller: authCubit.passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  filled: true,
                  fillColor: const Color(0xFFFFFDE4),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                    color: Color(0xFF4A4E69),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFF4A4E69),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                      widget.onTogglePassword();
                    },
                  ),
                ),
                validator: authCubit.passwordValidator,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child:
                    state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.zero,
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (authCubit.validateLogin()) {
                              authCubit.login();
                            }
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3A86FF), Color(0xFF00B4D8)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
              ),
            ],
          ),
        );
      },
    );
  }
}
