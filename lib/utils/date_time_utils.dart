import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String formatEEEEMMMddyyyy = "EEEE, MMM dd yyyy";
  static const String formatddMMMyyyy = "dd MMM yyyy";
  static const String formatMMMddyyyy = "MMM-dd-yyyy";
  static const String formatMMMyyyy = "MMM, yyyy";
  static const String formatyyyy = "yyyy";
  static const String formatMMMM = "MMMM";
  static const String formatEEE = "EEE";
  static const String formatdd = "dd";
  static const String formatMMMdd = "MMM, dd";

  static DateTime from(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  static String format(DateTime dateTime, String formatPattern) {
    return DateFormat(formatPattern).format(dateTime);
  }

  // TODO revert extension
  static String timeDifference(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    final isPast = difference.isNegative;

    final absDifference = difference.abs();

    if (absDifference.inDays >= 365) {
      final years = (absDifference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''}${isPast ? ' ago' : ''}';
    } else if (absDifference.inDays >= 30) {
      final months = (absDifference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''}${isPast ? ' ago' : ''}';
    } else if (absDifference.inDays >= 1) {
      return '${absDifference.inDays} day${absDifference.inDays > 1 ? 's' : ''}${isPast ? ' ago' : ''}';
    } else if (absDifference.inHours >= 1) {
      return '${absDifference.inHours} hour${absDifference.inHours > 1 ? 's' : ''}${isPast ? ' ago' : ''}';
    } else if (absDifference.inMinutes >= 1) {
      return '${absDifference.inMinutes} minute${absDifference.inMinutes > 1 ? 's' : ''}${isPast ? ' ago' : ''}';
    } else {
      return 'just now';
    }
  }

  /// TODO revert extension
  /// returns [months, days, hours]
  static List<int> timeDifferences(DateTime dateTime) {
    final DateTime now = DateTime.now();

    int months = 0;
    int days = 0;
    int hours = 0;

    // Calculate months difference
    while (DateTime(now.year, now.month + months + 1, now.day).isBefore(dateTime)) {
      months++;
    }

    // Set the current date and time up to the calculated months
    DateTime current = DateTime(now.year, now.month + months, now.day, now.hour, now.minute, now.second);

    // Calculate days difference
    while (current.add(const Duration(days: 1)).isBefore(dateTime)) {
      current = current.add(const Duration(days: 1));
      days++;
    }

    // Calculate remaining hours
    final hoursDifference = dateTime.difference(current);
    hours = hoursDifference.inHours;

    return [months, days, hours];
  }
}
