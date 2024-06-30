abstract class EditProfileStates {}

class EditProfileInitialState extends EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileSuccessState extends EditProfileStates {}

class EditProfileNetworkErrorState extends EditProfileStates {}

class EditProfileFailedState extends EditProfileStates {
  final String msg;

  EditProfileFailedState({required this.msg});
}

class UploadImageStates extends EditProfileStates {}
