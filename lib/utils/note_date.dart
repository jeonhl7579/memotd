import 'package:intl/intl.dart';

class NoteDate {
  static String gridDateFormat(String dateTime) {
    return DateFormat('yyyy MM dd').format(DateTime.parse(dateTime));
  }

  // DateTime을 변수로 받아서 년 월 일 시 분형식으로 반환
  static String detailDateFormat(DateTime dateTime) {
    return DateFormat('yyyy년 MM월 dd일 HH:mm').format(dateTime);
  }
}
