import 'package:tempo/core/database/database.dart';

// Extension to convert Drift User to domain model
extension UserExtension on User {
  String get fullName => '$firstName $lastName';

  String get displayName => fullName.isNotEmpty ? fullName : email;

  bool get hasPhoto => photoUrl != null && photoUrl!.isNotEmpty;

  String get initials {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    }
    if (firstName.isNotEmpty) {
      return firstName[0].toUpperCase();
    }
    if (email.isNotEmpty) {
      return email[0].toUpperCase();
    }
    return 'U';
  }
}
