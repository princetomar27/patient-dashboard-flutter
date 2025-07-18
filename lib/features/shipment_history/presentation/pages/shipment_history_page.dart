import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shipment_history/shipment_history_cubit.dart';
import '../widgets/shipment_card.dart';
import 'shipment_details_page.dart';

class ShipmentHistoryPage extends StatelessWidget {
  const ShipmentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentCubit, ShipmentState>(
      builder: (context, state) {
        if (state is ShipmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShipmentFailed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ShipmentCubit>().loadShipmentHistory();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is ShipmentHistoryLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Shipment History',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF22223B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Track all your medication deliveries',
                  style: TextStyle(fontSize: 16, color: Color(0xFF6C757D)),
                ),
                const SizedBox(height: 24),
                // Shipment List
                Expanded(
                  child: ListView.separated(
                    itemCount: state.shipments.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final shipment = state.shipments[index];
                      return ShipmentCard(
                        shipment: shipment,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ShipmentDetailsPage(
                                    shipmentId: shipment.id,
                                  ),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 16),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }
        return const Center(child: Text('No shipments available'));
      },
    );
  }
}
