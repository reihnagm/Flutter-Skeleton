import 'package:intl/intl.dart';

class ConnexistHelper {
  static String formatCurrency(double number) {
    final NumberFormat _fmt = NumberFormat.currency(locale: 'id', symbol: '');
    String s = _fmt.format(number);
    String _format = s.toString().replaceAll(RegExp(r"([,]*00)(?!.*\d)"), "");
    return _format;
  }
}
