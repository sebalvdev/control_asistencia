import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// import '../models/qr_scanner_model.dart';

abstract class QrScannerLocalDataSource {
  Future<bool> verifiQrCode(String serial);
}

const cacheQrScanner = 'CACHE_ESCANER_QR';

class QrScannerLocalDataSourceImpl implements QrScannerLocalDataSource {
  final SharedPreferences sharedPreferences;

  QrScannerLocalDataSourceImpl ({required this.sharedPreferences});
  
  @override
  Future<bool> verifiQrCode(String serial) async {
    // final jsonString =  sharedPreferences.getString(cacheQrScanner);
    // bool result = false;
    // if(jsonString != null) {
    //   List<QrScannerModel> qrScannerList = qrScannerModelFromJson(jsonString);
    //   for (var i in qrScannerList) {
    //     if (i.serial == serial) {
    //       result = true;
    //     }
    //   }
    // }
    // return result;
    return true;
  }
}