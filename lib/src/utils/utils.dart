import 'package:intl/intl.dart';

class Utils {
  /// returns [DateTime] representation of millisecond time
  static String getDateTimeFromMilliseconds(int time) {
    if (time == null) return null;

    DateTime date = DateTime.fromMicrosecondsSinceEpoch(time * 1000000);
    return getDateRepresentation(date);
  }

  /// returns [String] representation of [DateTime]
  static String getDateRepresentation(DateTime time) {
    DateFormat format = DateFormat('d MMM yy');

    return format.format(time);
  }
}
