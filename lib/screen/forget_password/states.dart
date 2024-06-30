abstract class SendCodeStates {}

class SendCodeInitialState extends SendCodeStates {}

class SendCodeLoadingState extends SendCodeStates {}

class NetworkErrorState extends SendCodeStates {}

class SendCodeFailedState extends SendCodeStates {
  final String msg;

  SendCodeFailedState({required this.msg});
}

class SendCodeSuccessState extends SendCodeStates {
  final String msg;

  SendCodeSuccessState({required this.msg});
}
