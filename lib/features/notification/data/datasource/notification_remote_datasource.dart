// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/cache_constants.dart';
import '../models/message_model.dart';


abstract class NotificationRemoteDatasource {
  Future<List<MessageModel>> getMessages();
}

class NotificationRemoteDatasourceImpl implements NotificationRemoteDatasource {
  final SharedPreferences sharedPreferences;

  NotificationRemoteDatasourceImpl({required this.sharedPreferences});
  
  get http => null;

  @override
  Future<List<MessageModel>> getMessages() async {
    List<MessageModel> result = notificationsFromJson('');
    
    final codigo = sharedPreferences.getInt(codeCache).toString();
    final response = await http.get(
      Uri.parse('http://tu_api_url.com?notifications=$codigo'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<MessageModel> data = notificationsFromJson(response.body);
      if (data.isNotEmpty) {
        result = data;
      } else {
        print('No hay notificaciones');
      }
    } else {
      // Error en la solicitud
      print('Error en la solicitud: ${response.statusCode}');
    }
    return result;
  }

}
