abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterNetworkErrorState extends RegisterStates {}

class ChanceVisibilityState extends RegisterStates {}
class ScanBarcode extends RegisterStates {}

class RegisterFailedState extends RegisterStates {
  final String msg;

  RegisterFailedState({required this.msg});
}

class UploadImageStates extends RegisterStates {}
class ValidateGuidStates extends RegisterStates {}
