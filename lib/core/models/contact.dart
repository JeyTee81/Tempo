import 'package:tempo/core/database/database.dart';

// Extension to convert Drift Contact to domain model
extension ContactExtension on Contact {
  String get fullName => '$firstName $lastName';

  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  bool get hasPhoto => photoUrl != null && photoUrl!.isNotEmpty;

  String get displayTitle {
    if (jobTitle != null && company != null) {
      return '$jobTitle at $company';
    } else if (jobTitle != null) {
      return jobTitle!;
    } else if (company != null) {
      return company!;
    }
    return '';
  }
}
