import 'dart:convert';

import 'package:control_asistencia_2/features/notification/domain/entities/message.dart';

String jsonData = '''
[
  {"notifications_id":"6","message":"thirth test","date_time":"2024-07-17","user_id":"0"},
  {"notifications_id":"7","message":"fourth test","date_time":"2024-07-17","user_id":"2"},
  {"notifications_id":"4","message":"secon test","date_time":"2024-07-16","user_id":"0"},
  {"notifications_id":"5","message":"secon test","date_time":"2024-07-16","user_id":"0"},
  {"notifications_id":"1","message":"test","date_time":"2024-07-06","user_id":"0"}
]
''';

List<MessageModel> notificationsFromJson(String str) {
  List<MessageModel> list = List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x))
  );

  list.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

  return list;
}
  
class MessageModel extends Message {

  const MessageModel({
    required super.id, required super.message, required super.date, required super.userId
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(id: json['notifications_id'], message: 'messaage', date: 'date_time', userId: 'user_id');
  }
}