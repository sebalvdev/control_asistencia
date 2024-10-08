import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [properties];
}

// General failures
class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message}) : super([message]);
}

class CacheFailure extends Failure {}

class UnkownFailure extends Failure {}
