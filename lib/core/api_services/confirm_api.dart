import 'package:http/http.dart' as http;

import '../constants/domain.dart';

class ConfirmApi{
  Future<bool> verificar(String codigo) async {
    // final url = "https://jcvctechnology.com/$codigo/api/api.php";
    final url = "https://$domainName/$codigo/api/api.php";
    try {
      final response = await http.get(Uri.parse(url));
      final result = response.statusCode == 200;
      if (result) {
      return result;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } 
  }
}