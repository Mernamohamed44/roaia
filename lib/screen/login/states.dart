abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class NetworkErrorState extends LoginStates {}

class NotVerifyState extends LoginStates {}
class ChanceVisibilityState extends LoginStates {}
class LoginFailedState extends LoginStates {
  final String msg;

  LoginFailedState({required this.msg});
}

class SendCodeSuccessState extends LoginStates {
  final String msg;

  SendCodeSuccessState({required this.msg});
}

class SendCodeFailedState extends LoginStates {
  final String msg;

  SendCodeFailedState({required this.msg});
}