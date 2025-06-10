import '../../../di/main.di.dart';
import '../helpers/date_time.helper.dart';

extension DateTimeExtension on DateTime {
  String formatDateTime(String formatter) {
    return sl<DateTimeHelper>().formatDateTime(
      dateTime: toLocal(),
      formatter: formatter.toString(),
    );
  }

  String agoDateTime() {
    return sl<DateTimeHelper>().agoDateTime(dateTime: this);
  }
}

extension IntDateTimeCoveter on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

// Convert String to DateTime
extension StringDateTimeConverter on String {
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }
}
