abstract class OtpStates {}

class OtpInitialState extends OtpStates {}

class OtpLoadingState extends OtpStates {}

class OtpSuccessState extends OtpStates {}

class NetworkErrorState extends OtpStates {}

class OtpFailedState extends OtpStates {
  final String msg;

  OtpFailedState({required this.msg});
}

class ChangeFullState extends OtpStates {}
