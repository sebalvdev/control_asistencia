import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/message_model.dart';
import '../repositories/notification_repositrory.dart';

class GetMessages implements UseCase<List<MessageModel>,Params>{
  final NotificationRepositrory repository;

  GetMessages({required this.repository});
  
  @override
  Future<Either<Failure, List<MessageModel>>> call(Params params) async {
    return await repository.getMessages();
  }
  
}

class Params extends Equatable {

  @override
  List<Object?> get props => [];
}