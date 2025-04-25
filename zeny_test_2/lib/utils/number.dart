import 'package:intl/intl.dart';

String formatNumber(double value) {
  final NumberFormat formatter = NumberFormat('#,##0.00');
  return formatter.format(value);
}