import 'package:intl/intl.dart';

class Formatter {
  static String currency(int? price) {
    if (price == null) {
      return "";
    }
    // return NumberFormat.decimalPattern().format(price) + ' đ';
    return NumberFormat.currency(locale: 'vi', symbol: '₫').format(price);
  }
}
