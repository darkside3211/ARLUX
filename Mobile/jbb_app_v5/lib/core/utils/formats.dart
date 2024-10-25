import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatDate(DateTime date) {
  initializeDateFormatting('en_PH');
  final localTime = date.toLocal();
  return DateFormat.yMd().add_jm().format(localTime);
}

String currencyFormat({required double value}) {
  final formatter = NumberFormat.currency(
    locale: 'en_PH',
    symbol: '₱',
    decimalDigits: 2,
  );
  return formatter.format(value);
}

String compactNumerFormat({required int value}) {
  final formatter = NumberFormat.compact();

  return formatter.format(value);
}
