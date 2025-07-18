import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection.dart';
import '../cubit/shipment_details/shipment_details_cubit.dart';
import '../widgets/shipment_details_card.dart';

class ShipmentDetailsPage extends StatelessWidget {
  final String shipmentId;

  const ShipmentDetailsPage({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ShipmentDetailsCubit(
            getShipmentDetailsUseCase: sl(),
            shipmentId: shipmentId,
          ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48),
          child: BlocBuilder<ShipmentDetailsCubit, ShipmentDetailsState>(
            builder: (context, state) {
              if (state is ShipmentDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShipmentDetailsFailed) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ShipmentDetailsCubit>()
                              .loadShipmentDetails(shipmentId: shipmentId);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is ShipmentDetailsLoaded) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF3A86FF),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Back to History',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF3A86FF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Shipment Details Card
                      ShipmentDetailsCard(shipment: state.shipment),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Shipment not found'));
            },
          ),
        ),
      ),
    );
  }
}
