import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';

import 'controller.dart';
import 'states.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitialState());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  final dioManager = DioManager();
  final formKey = GlobalKey<FormState>();
  final controllers = EditProfileControllers();
  final logger = Logger();
  bool isObscure = true;
  File? profileImage;

  Future<void> editProfile() async {
    if (formKey.currentState!.validate()) {
      emit(EditProfileLoadingState());
      try {
        final response = await dioManager.put(
          ApiConstants.editProfile,
          data: FormData.fromMap({
            "FirstName": controllers.firstNameController.text,
            "LastName": controllers.lastNameController.text,
            "UserName": controllers.userNameController.text,
            "Email": controllers.emailController.text,
            'PhoneNumber':controllers.phoneController.text,
            if (profileImage != null)
              "ImageUrl": profileImage != null
                  ? MultipartFile.fromFileSync(
                      profileImage!.path,
                      filename: profileImage!.path.split("/").last,
                    )
                  : null,
          }),
        );

        if (response.statusCode == 200) {
          emit(EditProfileSuccessState());
        } else {
          emit(EditProfileFailedState(msg: "${response.data}"));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(EditProfileFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(EditProfileFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(EditProfileNetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(EditProfileFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(EditProfileNetworkErrorState());
    }
    logger.e(e);
  }

  chooseProfileImage() {
    ImagePicker.platform.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        profileImage = File(value.path);
        emit(UploadImageStates());
      }
    });
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
