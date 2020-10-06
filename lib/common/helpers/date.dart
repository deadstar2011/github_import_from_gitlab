import 'package:intl/intl.dart';

String dateFormat(String date, {String format = 'Hm'}) {
  if (date == null) {
    return null;
  }
  try {
    final dateObj = DateTime.parse(date).toLocal();
    return DateFormat(format).format(dateObj);
  } catch (_) {
    return '';
  }
}
