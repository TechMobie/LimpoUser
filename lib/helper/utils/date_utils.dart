// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

import 'common_functions.dart';
import 'constants.dart';

class DateUtilities {
  static const String kMainSourceFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

  static const kSourceFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
  static const String dd_mm_yyyy_hh_mm = "dd-MM-yyyy HH:mm";
  static const String dd_mm_yyyy_hh_mm_a = "dd-MM-yyyy hh:mm a";
  static const String dd_mm_yyyy_hh_mm_ss_a = "dd/MM/yyyy',' hh:mm a";
  static const String dd_mm_yyyy_hh_mm_ss_aa = "dd-MM-yyyy' at 'hh:mm a";
  static const String dd_mm_hh_mm_ss_aa = "dd-MMM' at 'hh:mm a";
  static const String dd_mm_yyyy_hh_mm_ss = "dd MMM yyyy',' hh:mm a";
  static const String dd_mm_yyyy_n_mm_ss_a = "dd/MM/yyyy'\n' hh:mm a";
  static const String dd_mm_yyyy = "dd MMM yyyy";
  static const String mmm_yyyy = "MMM yyyy";
  static const String dd_mmm = "dd MMM";
  static const String dd_eee = "dd\nEE";
  static const String mm_yyyy = "MM/yyyy";
  static const String dd = "d";
  static const String mmm = "MMMM yyyy";
  static const String yyyy = "yyyy";
  static const String file_name_date = "dd MMM yyyy";
  static const String dd_mm_yyyy_ = "dd-MM-yyyy";
  static const String yyyy_mm_dd = "yyyy-MM-dd";
  static const weekDayDateMonth = "EEEE, d MMMM";

  static const String ddmmyyyy = "dd/MM/yyyy";
  static const String mmddyyyy = "MM/dd/yyyy";

  static const String ddmmyywithdash = "dd-MM-yyyy";
  static const String hh_mm_ss = "HH:mm:ss";
  static const String hh_mm_a = "hh:mm a";
  static const String h_mm_a = "h:mm a";
  static const String eeee = "EEEE";
  static const String ee = "EE";
  static const String eee_dd_mmm_yyyy = "EEEE, dd MMM yyyy";
  static const String eee_ddmmmyyyy = "EEEE, $ddmmyyyy";

  static const String dd_mmm_yyy_h_mm_a = "dd MMM yyyy',' h:mma";
  static const String mmmm = "MMMM";

  static const String mmm_withComma_yyyy = "MMMM, yyyy";
  static const String date_And_month = "d MMMM";
  static const String hour_minute = "jm";

  String convertServerDateToFormatterString(String dateString,
      {String? formatter}) {
    // ignore: unnecessary_null_comparison
    if (dateString == "" || dateString == null) return "";
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
            DateTime.parse(dateString).millisecondsSinceEpoch)
        .toLocal();
    return getFormattedDateString(
      getDateFromString(dateTime.toIso8601String(), formatter: kSourceFormat),
      formatter: formatter,
    );
  }

  static String convertDateTimeToString({
    required DateTime date,
    String dateFormatter = yyyy_mm_dd,
  }) {
    final DateFormat formatter = DateFormat(dateFormatter);
    return formatter.format(date);
  }

  static String convertDateTimeForShowPickupAndDelivery({
    required DateTime date,
    String dateFormatter = yyyy_mm_dd,
  }) {
    final DateFormat formatter = DateFormat.yMMMEd(myLocale.toString());
    return formatter.format(date);
  }

  String getFormattedDateString(DateTime date, {String? formatter}) {
    // ignore: prefer_conditional_assignment
    if (formatter == null) {
      formatter = kMainSourceFormat;
    }
    return DateFormat(formatter).format(date);
  }

  DateTime getDateFromString(String dateString, {String? formatter}) {
    // ignore: prefer_conditional_assignment
    if (formatter == null) {
      formatter = kMainSourceFormat;
    }

    //It is must to put (true) flag inside pars, bcz its for utc = true;
    //we have to explicitly provide that flag that we wanna convert utl
    //to local time format.
    return DateFormat(formatter).parse(dateString, true);
  }

  String timeAgoSinceDate(String dateString) {
    if (dateString != "null") {
      DateTime date = DateTime.parse(dateString);
      final date2 = DateTime.now();
      final difference = date2.difference(date);

      if ((date2.hour - difference.inHours).isNegative &&
          difference.inHours <= 24) {
        return "Yesterday";
      } else if (difference.inSeconds <= 60) {
        return 'Online';
      } else if (difference.inMinutes <= 60) {
        return 'Last seen ${difference.inMinutes}min ago';
      } else if (difference.inMinutes > 60 && difference.inHours <= 24) {
        return convertServerDateToFormatterString(date.toString(),
            formatter: hh_mm_a);
      } else if (difference.inHours > 24 && difference.inDays <= 2) {
        return "Yesterday";
      } else {
        return convertServerDateToFormatterString(date.toString(),
            formatter: dd_mm_hh_mm_ss_aa);
      }
    }

    return "";
  }

  String lastMessageAt({String? date}) {
    if (!isNullEmptyOrFalse(date)) {
      final date1 = DateTime.parse(date!);
      final date2 = DateTime.now();

      final difference = date2.difference(date1);

      if ((date2.hour - difference.inHours).isNegative &&
          difference.inHours <= 24) {
        return "Yesterday";
      } else if (difference.inMinutes <= 60 && difference.inMinutes >= 1) {
        return '${difference.inMinutes} min ago';
      } else if (difference.inSeconds <= 60) {
        return "Just now";
      } else if (difference.inDays == 0) {
        return convertServerDateToFormatterString(date.toString(),
            formatter: hh_mm_a);
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else {
        return convertServerDateToFormatterString(date.toString(),
            formatter: dd_mmm);
      }
    } else {
      return "";
    }
  }
}
