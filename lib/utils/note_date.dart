import 'package:intl/intl.dart';

class NoteDate {
  static String gridDateFormat(String dateTime) {
    return DateFormat('yyyy MM dd').format(DateTime.parse(dateTime));
  }
}
