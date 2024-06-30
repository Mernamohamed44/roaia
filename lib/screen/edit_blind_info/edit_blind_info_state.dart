part of 'edit_blind_info_cubit.dart';

@immutable
abstract class EditBlindInfoStates {}

class EditBlindInfoInitial extends EditBlindInfoStates {}

class EditBlindLoadingState extends EditBlindInfoStates {}

class EditBlindSuccessState extends EditBlindInfoStates {}

class EditBlindNetworkErrorState extends EditBlindInfoStates {}
class UploadImageStates extends EditBlindInfoStates {}

class EditBlindFailedState extends EditBlindInfoStates {
  final String msg;

  EditBlindFailedState({required this.msg});
}