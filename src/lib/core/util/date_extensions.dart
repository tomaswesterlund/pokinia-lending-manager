import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String toFormattedDate() {
    var today = DateTime.now();
    if (year == today.year) {
      final dateFormat = DateFormat('MMM-dd');
    return dateFormat.format(this);
    } else {
      final dateFormat = DateFormat('yyyy-MMM-dd');
    return dateFormat.format(this);
    }
    
  }
}