import 'package:flutter/material.dart';

enum HomeTabEnum { dashboard, shipmentHistory }

extension HomeTabEnumExtension on HomeTabEnum {
  String get displayName {
    switch (this) {
      case HomeTabEnum.dashboard:
        return 'Dashboard';
      case HomeTabEnum.shipmentHistory:
        return 'Shipment History';
    }
  }

  IconData get icon {
    switch (this) {
      case HomeTabEnum.dashboard:
        return Icons.dashboard;
      case HomeTabEnum.shipmentHistory:
        return Icons.inventory;
    }
  }

  int get index {
    switch (this) {
      case HomeTabEnum.dashboard:
        return 0;
      case HomeTabEnum.shipmentHistory:
        return 1;
    }
  }

  static HomeTabEnum fromIndex(int index) {
    switch (index) {
      case 0:
        return HomeTabEnum.dashboard;
      case 1:
        return HomeTabEnum.shipmentHistory;
      default:
        throw ArgumentError('Invalid tab index: $index');
    }
  }
}
