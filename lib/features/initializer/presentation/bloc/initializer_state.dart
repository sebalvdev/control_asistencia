part of 'initializer_bloc.dart';

sealed class InitializerState extends Equatable {
  const InitializerState();
  
  @override
  List<Object> get props => [];
}

class InitializerInitial extends InitializerState {}

class InitializerLoading extends InitializerState {}

class InitializerSuccess extends InitializerState {}

class AuthError extends InitializerState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
