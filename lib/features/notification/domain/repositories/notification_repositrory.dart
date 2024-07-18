import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/message_model.dart';

abstract class NotificationRepositrory{
  Future<Either<Failure, List<MessageModel>>> getMessages();
}