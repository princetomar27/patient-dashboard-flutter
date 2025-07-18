import 'package:flutter/material.dart';

import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/user_status_enum.dart';

class PatientInfoCard extends StatelessWidget {
  final PatientEntity patient;

  const PatientInfoCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 248, 247, 235),
            Colors.white,
            Color.fromARGB(255, 248, 245, 197),

            Color.fromARGB(255, 248, 247, 235),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and badges
          Row(
            children: [
              const Text(
                'Patient Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF22223B),
                ),
              ),
              const Spacer(),
              // Active badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF28A745),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  patient.status.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Billing OK badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF28A745),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Billing OK',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Patient details
          _buildDetailRow('Full Name', patient.fullName, isValueBold: true),
          const SizedBox(height: 12),
          _buildDetailRow('Patient ID', patient.patientId),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Current Plan',
            patient.currentPlan,
            isPlan: true,
            isValueBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isPlan = false,
    bool isValueBold = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6C757D),
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isValueBold ? FontWeight.bold : FontWeight.w500,
            color: isPlan ? const Color(0xFF3A86FF) : const Color(0xFF22223B),
          ),
        ),
      ],
    );
  }
}
