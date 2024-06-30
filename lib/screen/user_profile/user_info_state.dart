part of 'user_info_cubit.dart';

@immutable
abstract class UserInfoStates {}

class UserInfoInitial extends UserInfoStates {}

class UserInfoLoadingState extends UserInfoStates {}

class UserInfoSuccessState extends UserInfoStates {}
class UserInfoFailedState extends UserInfoStates {
  final String msg;

  UserInfoFailedState({required this.msg});
}

class NetworkErrorState extends UserInfoStates {}
class UnAuthorizedState extends UserInfoStates {}
