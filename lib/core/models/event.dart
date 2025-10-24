import 'package:tempo/core/database/database.dart';

// Extension to convert Drift Event to domain model
extension EventExtension on Event {
  Duration get duration => endDate.difference(startDate);

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(startDate.year, startDate.month, startDate.day);
    return today == eventDay;
  }

  bool get isPast => startDate.isBefore(DateTime.now());

  bool get isUpcoming => startDate.isAfter(DateTime.now());

  String get timeRange {
    if (isAllDay) return 'All day';

    final startTime =
        '${startDate.hour.toString().padLeft(2, '0')}:${startDate.minute.toString().padLeft(2, '0')}';
    final endTime =
        '${endDate.hour.toString().padLeft(2, '0')}:${endDate.minute.toString().padLeft(2, '0')}';

    return '$startTime - $endTime';
  }

  String get displayLocation {
    if (location == null || location!.isEmpty) return 'No location';
    return location!;
  }

  bool get hasLocation => location != null && location!.isNotEmpty;
}
