import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String message;
  final String date;
  final String userId;

  const Message(
      {required this.id,
      required this.message,
      required this.date,
      required this.userId
    });

  @override
  List<Object?> get props => [id, message, date, userId];
}
