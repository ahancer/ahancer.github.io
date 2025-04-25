import 'package:intl/intl.dart';

double exchangeRateTHB = 33.6;

String formatNumber(double value) {
  final NumberFormat formatter = NumberFormat('#,##0.00');
  return formatter.format(value);
}