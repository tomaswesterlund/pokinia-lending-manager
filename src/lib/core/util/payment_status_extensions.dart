import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:string_capitalize/string_capitalize.dart';

extension StringExtensions on PaymentStatus {
  String toFormatted() {
    if (this == PaymentStatus.empty) {
      return 'No loans';
    } else {
      return name.toString().capitalize();
    }
  }
}
