abstract class ResetPasswordStates {}

class ResetPasswordInitialState extends ResetPasswordStates {}

class ResetPasswordLoadingState extends ResetPasswordStates {}

class ResetPasswordSuccessState extends ResetPasswordStates {}
class ChanceVisibilityState extends ResetPasswordStates {}

class NetworkErrorState extends ResetPasswordStates {}


class ResetPasswordFailedState extends ResetPasswordStates {
  final String msg;

  ResetPasswordFailedState({required this.msg});
}

