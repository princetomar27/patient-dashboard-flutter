import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../domain/entities/home_tab_enum.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Initialize tab controller in the cubit
    context.read<HomeCubit>().initializeTabController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();

          return Column(
            children: [
              // Blue Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3A86FF), Color(0xFF00B4D8)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Heart icon in light blue square
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // App name
                        const Text(
                          'MediCare+',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        // Logout icon
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (state is HomeTabChanged &&
                        state.currentTab == HomeTabEnum.dashboard)
                      const Text(
                        'Sarah Johnson',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      )
                    else
                      const Text(
                        'MediCare+',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                  ],
                ),
              ),
              // Tab Navigation
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: homeCubit.tabController,
                  labelColor: const Color(0xFF3A86FF),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF3A86FF),
                  indicatorWeight: 3,
                  tabs:
                      HomeTabEnum.values
                          .map(
                            (tab) => Tab(
                              icon: Icon(tab.icon),
                              text: tab.displayName,
                            ),
                          )
                          .toList(),
                ),
              ),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: homeCubit.tabController,
                  children:
                      HomeTabEnum.values.map((tab) {
                        switch (tab) {
                          case HomeTabEnum.dashboard:
                            return const DashboardPage();
                          case HomeTabEnum.shipmentHistory:
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inventory,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Shipment History',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Coming Soon',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }
                      }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
