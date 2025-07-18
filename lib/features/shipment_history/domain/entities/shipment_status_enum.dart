enum ShipmentStatus { shipped, delivered, inTransit, pending }

extension ShipmentStatusExtension on ShipmentStatus {
  String get displayName {
    switch (this) {
      case ShipmentStatus.shipped:
        return 'Shipped';
      case ShipmentStatus.delivered:
        return 'Delivered';
      case ShipmentStatus.inTransit:
        return 'In Transit';
      case ShipmentStatus.pending:
        return 'Pending';
    }
  }

  String get color {
    switch (this) {
      case ShipmentStatus.shipped:
        return '#3A86FF'; // Blue
      case ShipmentStatus.delivered:
        return '#28A745'; // Green
      case ShipmentStatus.inTransit:
        return '#FFC107'; // Yellow/Orange
      case ShipmentStatus.pending:
        return '#6C757D'; // Grey
    }
  }
}
