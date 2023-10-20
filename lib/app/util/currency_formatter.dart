import 'package:intl/intl.dart';

class Formatter {
  static formatNumberCOP(String number) {
    final numberFormat = NumberFormat.currency(locale: 'en', symbol: "\$");
    return numberFormat.format(double.parse(number));
  }
  static unFormatNumberCOP(String number){
    return number.replaceAll('\$', '').replaceAll(',', '');
  }
  static String formatDate(DateTime date) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}
}
