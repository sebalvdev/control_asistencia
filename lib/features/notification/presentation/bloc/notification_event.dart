part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}
class GetMessages extends NotificationEvent {
  final List<MessageModel> messaages;

  const GetMessages({required this.messaages});
}
