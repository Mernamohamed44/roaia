part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsStates {}

class NotificationsInitial extends NotificationsStates {}
class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {}
class DeleteNotificationsLoadingState extends NotificationsStates {}
class DeleteNotificationsSuccessState extends NotificationsStates {}

class NetworkErrorState extends NotificationsStates {}
class UploadImageStates extends NotificationsStates {}

class NotificationsFailedState extends NotificationsStates {
  final String msg;

  NotificationsFailedState({required this.msg});
}
class DeleteNotificationsFailedState extends NotificationsStates {
  final String msg;

  DeleteNotificationsFailedState({required this.msg});
}


