part of 'contacts_cubit.dart';

@immutable
abstract class GetContactsStates {}

class ContactsInitial extends GetContactsStates {}
class GetContactsLoadingState extends GetContactsStates {}

class GetContactsSuccessState extends GetContactsStates {}
class GetContactsFailedState extends GetContactsStates {
  final String msg;

  GetContactsFailedState({required this.msg});
}
class NetworkErrorState extends GetContactsStates {}
class UnAuthorizedState extends GetContactsStates {}

