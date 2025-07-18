import 'package:flutter/material.dart';

import '../../domain/entities/patient_entity.dart';

class MedicationCard extends StatelessWidget {
  final PatientEntity patient;

  const MedicationCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Next Delivery Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF3A86FF),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Next Delivery',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF22223B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _formatFullDate(patient.nextDeliveryDate),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF22223B),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: _getDeliveryStatusColor(),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getDeliveryStatusText(),
                    style: TextStyle(
                      fontSize: 14,
                      color: _getDeliveryStatusColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Medication Status Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
              Row(
                children: [
                  const Icon(
                    Icons.medication,
                    color: Color(0xFF28A745),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Medication Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF22223B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      '${patient.remainingMedication}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'doses remaining',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Progress bar
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9ECEF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _getProgressFactor(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF28A745),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatFullDate(DateTime date) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final dayName = days[date.weekday - 1];
    final monthName = months[date.month - 1];

    return '$dayName, $monthName ${date.day}, ${date.year}';
  }

  double _getProgressFactor() {
    const totalDoses = 30.0;
    return (patient.remainingMedication / totalDoses).clamp(0.0, 1.0);
  }

  String _getDeliveryStatusText() {
    final now = DateTime.now();
    final deliveryDate = patient.nextDeliveryDate;

    final today = DateTime(now.year, now.month, now.day);
    final deliveryDay = DateTime(
      deliveryDate.year,
      deliveryDate.month,
      deliveryDate.day,
    );

    final difference = deliveryDay.difference(today).inDays;

    if (difference == 0) {
      return 'Today!';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference > 1) {
      return 'In $difference days';
    } else {
      return '${difference.abs()} days ago';
    }
  }

  Color _getDeliveryStatusColor() {
    final now = DateTime.now();
    final deliveryDate = patient.nextDeliveryDate;

    final today = DateTime(now.year, now.month, now.day);
    final deliveryDay = DateTime(
      deliveryDate.year,
      deliveryDate.month,
      deliveryDate.day,
    );

    final difference = deliveryDay.difference(today).inDays;

    if (difference == 0) {
      // Today - Orange/Red for urgency
      return const Color(0xFFFF6B35);
    } else if (difference == 1) {
      // Tomorrow - Blue for upcoming
      return const Color(0xFF3A86FF);
    } else if (difference > 1) {
      // Future - Green for good
      return const Color(0xFF28A745);
    } else {
      // Past - Grey for overdue
      return const Color(0xFF6C757D);
    }
  }
}
