part of 'blind_info_cubit.dart';

@immutable
abstract class BlindInfoStates {}

class BlindInfoInitial extends BlindInfoStates {}

class BlindInfoLoadingState extends BlindInfoStates {}

class BlindInfoSuccessState extends BlindInfoStates {}

class BlindInfoFailedState extends BlindInfoStates {
  final String msg;

  BlindInfoFailedState({required this.msg});
}

class NetworkErrorState extends BlindInfoStates {}
