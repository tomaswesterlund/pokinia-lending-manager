import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toFormattedCurrency() {
    final numberFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
      locale: 'en_US', // Set your desired locale here
    );

    return numberFormat.format(this);
  }
}