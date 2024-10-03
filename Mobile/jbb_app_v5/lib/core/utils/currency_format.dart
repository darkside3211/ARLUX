import 'package:intl/intl.dart';

String currencyFormat({required double value}) {
  final formatter = NumberFormat.currency(
    locale: 'en_PH',
    symbol: '₱',
    decimalDigits: 2,
  );
  return formatter.format(value);
}
