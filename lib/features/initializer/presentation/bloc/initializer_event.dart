part of 'initializer_bloc.dart';

sealed class InitializerEvent extends Equatable {
  const InitializerEvent();

  @override
  List<Object> get props => [];
}

class VerifyCodeEvent extends InitializerEvent {}