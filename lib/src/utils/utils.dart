class Utils {
  /// returns [DateTime] representation of millisecond time
  static DateTime getDateTimeFromMilliseconds(int time) {
    if (time == null) return null;

    return DateTime.fromMicrosecondsSinceEpoch(time * 1000);
  }
}
