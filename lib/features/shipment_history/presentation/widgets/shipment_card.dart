import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/shipment_entity.dart';
import '../../domain/entities/shipment_status_enum.dart';

class ShipmentCard extends StatelessWidget {
  final ShipmentEntity shipment;
  final VoidCallback onTap;

  const ShipmentCard({super.key, required this.shipment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getStatusColor(shipment.status).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getStatusIcon(shipment.status),
                color: _getStatusColor(shipment.status),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${shipment.medicationName} ${shipment.medicationDosage}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF22223B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${DateFormat('MMM dd, yyyy').format(shipment.deliveryDate)} • ${shipment.doses} doses',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6C757D),
                    ),
                  ),
                ],
              ),
            ),
            // Status Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(shipment.status),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    shipment.status.displayName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  shipment.trackingNumber,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6C757D),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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

  IconData _getStatusIcon(ShipmentStatus status) {
    switch (status) {
      case ShipmentStatus.shipped:
        return Icons.local_shipping;
      case ShipmentStatus.delivered:
        return Icons.check_circle;
      case ShipmentStatus.inTransit:
        return Icons.local_shipping;
      case ShipmentStatus.pending:
        return Icons.schedule;
    }
  }
}
