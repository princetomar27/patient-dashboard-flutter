import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/shipment_entity.dart';
import '../../domain/entities/shipment_status_enum.dart';

class ShipmentDetailsCard extends StatelessWidget {
  final ShipmentEntity shipment;

  const ShipmentDetailsCard({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipment Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF22223B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(shipment.status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  shipment.status.displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Details
          _buildDetailRow(
            icon: Icons.calendar_today,
            label: 'Date',
            value: DateFormat(
              'EEEE, MMMM dd, yyyy',
            ).format(shipment.deliveryDate),
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            icon: Icons.medication,
            label: 'Medication',
            value: '${shipment.medicationName} ${shipment.medicationDosage}',
            subtitle: 'Quantity: ${shipment.doses} doses',
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            icon: Icons.local_shipping,
            label: 'Tracking Number',
            value: shipment.trackingNumber,
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            icon: Icons.location_on,
            label: 'Delivery Address',
            value: shipment.deliveryAddress,
          ),
          const SizedBox(height: 32),
          // Status message
          if (shipment.status == ShipmentStatus.shipped ||
              shipment.status == ShipmentStatus.inTransit)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF3A86FF).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    color: Color(0xFF3A86FF),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'In Transit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3A86FF),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your medication is on its way! You can track its progress using the tracking number above.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3A86FF).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF3A86FF), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6C757D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF22223B),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6C757D),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(ShipmentStatus status) {
    switch (status) {
      case ShipmentStatus.shipped:
        return const Color(0xFF3A86FF);
      case ShipmentStatus.delivered:
        return const Color(0xFF28A745);
      case ShipmentStatus.inTransit:
        return const Color(0xFFFFC107);
      case ShipmentStatus.pending:
        return const Color(0xFF6C757D);
    }
  }
}
