enum BillingStatus { ok, pending, overdue }

extension BillingStatusExtension on BillingStatus {
  static BillingStatus fromBillingStatus(String status) {
    switch (status.toLowerCase()) {
      case 'ok':
        return BillingStatus.ok;
      case 'pending':
        return BillingStatus.pending;
      case 'overdue':
        return BillingStatus.overdue;
      default:
        throw ArgumentError('Invalid billing status: $status');
    }
  }

  String get displayName {
    switch (this) {
      case BillingStatus.ok:
        return 'Current';
      case BillingStatus.pending:
        return 'Pending';
      case BillingStatus.overdue:
        return 'Overdue';
    }
  }
}
