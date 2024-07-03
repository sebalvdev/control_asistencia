import 'dart:convert';

import '../../domain/entities/access_pass.dart';

List<AccessPassModel> qrScannerModelFromJson(String str) =>
    List<AccessPassModel>.from(json.decode(str).map((x) =>
      AccessPassModel.fromJson(x)));

class AccessPassModel extends AccessPass {
  const AccessPassModel({
    required super.qrCode
  });

  factory AccessPassModel.fromJson(Map<String, dynamic> json) {
    return AccessPassModel(qrCode: json['serial']);
  }

  Map<String, dynamic> toJson() {
    return {
      'serial': qrCode,
    };
  }
}