import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String header;
  final String message;
  final String date;
  final String userId;

  const Message(
      {required this.header,
      required this.message,
      required this.date,
      required this.userId
    });

  @override
  List<Object?> get props => [header, message, date, userId];
}
