part of 'add_contact_cubit.dart';

@immutable
abstract class AddContactStates {}

class AddContactInitial extends AddContactStates {}
class AddContactLoadingState extends AddContactStates {}

class AddContactSuccessState extends AddContactStates {}

class AddContactNetworkErrorState extends AddContactStates {}

class AddContactFailedState extends AddContactStates {
  final String msg;

  AddContactFailedState({required this.msg});
}

class UploadImageStates extends AddContactStates {}

