import 'package:intl/intl.dart';

class Formatter {
  static formatNumberCOP(String number) {
    final numberFormat = NumberFormat.currency(locale: 'en', symbol: "\$");
    return numberFormat.format(double.parse(number));
  }
  static unFormatNumberCOP(String number){
    return number.replaceAll('\$', '').replaceAll(',', '');
  }
}
