import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/notification_repositrory.dart';
import '../datasource/notification_remote_datasource.dart';
import '../models/message_model.dart';

class NotificationRepositoryImpl implements NotificationRepositrory {
  final NotificationRemoteDatasource remoteDatasource;

  NotificationRepositoryImpl({
    required this.remoteDatasource
  });
  
  @override
  Future<Either<Failure, List<MessageModel>>> getMessages() async {
    try{
      final result = await remoteDatasource.getMessages();
      return Future.value((right(result)));
    } on CacheFailure {
      return Future.value(left(CacheFailure()));
    } on UnkownFailure {
      return Future.value(left(UnkownFailure()));
    }
  }
}