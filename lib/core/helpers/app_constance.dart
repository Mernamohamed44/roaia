import 'package:intl/intl.dart';

class AppConstance {
  static const Map<String, dynamic> headers = {
    "Content-Type": "application/json",
    "Connection": "keep-alive"
  };

  // date & time & currency format
  static DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  static DateFormat timeFormat = DateFormat('hh:mm a');
  static NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

// image path
// static const String imagePathApi = 'http://209.250.237.58:4054/images/';
}