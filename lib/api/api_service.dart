import 'dart:convert';

import 'package:get/get.dart';

class ApiService {
  static Future<void> get({
    required var url,
    required Function(
      bool success,
      String message,
      Map<String, dynamic> response,
    )
        callback,
  }) {
    return GetConnect().get(url).then((value) {
      var code = value.statusCode;
      var success = code == 200 && (value.body['status'] ?? true) == true;
      var message = success ? "Berhasil" : "Terjadi Kesalahan";

      return callback(success, message, jsonDecode(value.bodyString!));
    });
  }
}
