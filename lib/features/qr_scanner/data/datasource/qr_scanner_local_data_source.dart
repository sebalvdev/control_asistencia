import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api_services/api.dart';
import '../../../../injection_container.dart';

// import '../models/qr_scanner_model.dart';

abstract class QrScannerLocalDataSource {
  Future<bool> verifiQrCode(String serial);
}

const cacheQrScanner = 'CACHE_ESCANER_QR';

class QrScannerLocalDataSourceImpl implements QrScannerLocalDataSource {
  final SharedPreferences sharedPreferences;

  QrScannerLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> verifiQrCode(String serial) async {
    final find = sl<FindAssistance>();
    final result = await find.findAssistance(qrCode: serial);
    if (result['success']) {
      return true;
    } else {
      return false;
    }
    // return false;
  }
}
