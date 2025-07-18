enum UserStatus { active, inactive }

extension UserStatusExtension on UserStatus {
  static UserStatus fromUserStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return UserStatus.active;
      case 'inactive':
        return UserStatus.inactive;
      default:
        throw ArgumentError('Invalid user status: $status');
    }
  }

  String get displayName {
    switch (this) {
      case UserStatus.active:
        return 'Active';
      case UserStatus.inactive:
        return 'Inactive';
    }
  }
}
