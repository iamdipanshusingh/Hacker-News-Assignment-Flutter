import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// returns [DateTime] representation of millisecond time
  static String getDateTimeFromMilliseconds(int time) {
    if (time == null) return null;

    DateTime date = DateTime.fromMicrosecondsSinceEpoch(time * 1000000);
    return getDateRepresentation(date);
  }

  /// returns [String] representation of [DateTime]
  static String getDateRepresentation(DateTime time) {
    DateFormat format = DateFormat('d MMM yy, ').add_jm();

    return format.format(time);
  }

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }


  static launchUrl(String url) async {
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      return false;
    }
  }
}
