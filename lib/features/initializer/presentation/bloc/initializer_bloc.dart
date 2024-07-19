import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'initializer_event.dart';
part 'initializer_state.dart';

class InitializerBloc extends Bloc<InitializerEvent, InitializerState> {
  InitializerBloc(super.initialState);

  // InitializerBloc() : super(InitializerInitial()) {
  //   on<InitializerEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }

  Stream<InitializerState> mapEventToState(InitializerEvent event) async* {
    if (event is VerifyCodeEvent) {
      yield InitializerLoading();
      try {
        final bool isVerified = await verifyCode();
        if (isVerified) {
          yield InitializerSuccess();
        } else {
          yield InitializerSuccess();
        }
      } catch (e) {
        yield AuthError(e.toString());
      }
    }
  }

  Future<bool> verifyCode() async {
    // Aquí implementa la lógica de verificación de código
    // int code = await uniqueNumber.getValue();
    // bool verify = await authenticate.getData(code.toString());
    // return verify;
    return true;
  }
}
