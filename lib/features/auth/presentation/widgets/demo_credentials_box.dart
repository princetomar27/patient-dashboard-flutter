import 'package:flutter/material.dart';

class DemoCredentialsBox extends StatelessWidget {
  const DemoCredentialsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demo Credentials:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4E69),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Email: test@example.com',
            style: TextStyle(color: Color(0xFF4A4E69)),
          ),
          Text(
            'Password: password123',
            style: TextStyle(color: Color(0xFF4A4E69)),
          ),
        ],
      ),
    );
  }
}
