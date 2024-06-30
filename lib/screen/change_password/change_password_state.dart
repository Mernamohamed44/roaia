part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {}

class NetworkErrorState extends ChangePasswordState {}
class ChanceVisibilityState extends ChangePasswordState {}

class ChangePasswordFailedState extends ChangePasswordState {
  final String msg;

  ChangePasswordFailedState({required this.msg});
}
