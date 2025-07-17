import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.favorite_border,
            color: Color(0xFF3A86FF),
            size: 48,
          ),
        ),
        const SizedBox(height: 24),
        // App Name
        const Text(
          'MediCare+',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF22223B),
          ),
        ),
        const SizedBox(height: 8),
        // Subtitle
        const Text(
          'Your health, delivered with care',
          style: TextStyle(fontSize: 16, color: Color(0xFF4A4E69)),
        ),
      ],
    );
  }
}
