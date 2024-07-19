import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import '../../data/models/message_model.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_messages.dart' as get_messages;

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  final get_messages.GetMessages getMessages;
  
  NotificationBloc({
    required this.getMessages}) 
    : super(NotificationInitial()) {
    on<GetMessages>((event, emit) async {
      emit(NotificationLoading());
      final result = await getMessages(get_messages.Params());
      await result.fold((failure) async => emit(NotificationFailure()), 
      (messages) async => emit(NotificationSuccess(messages: messages)));
    });
  }
}
