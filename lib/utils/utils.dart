import 'package:intl/intl.dart';
import 'package:swift_flutter/config/app_config.dart';

class Utils{
  static String getImageUrl(int id){
    return '${AppConfig.baseUrl}/file/$id';
  }

  static String formatCurrency(double amount){
    final f = NumberFormat("#,##0.00", "en_US");
    return f.format(amount);
  }

  static bool isNull(Object object){
    return object == null;
  }

  static bool isNotNull(Object object){
    return object != null;
  }
}