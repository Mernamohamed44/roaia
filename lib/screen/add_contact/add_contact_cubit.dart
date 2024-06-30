import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';


import '../../core/networking/dio_manager.dart';

part 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactStates> {
  AddContactCubit() : super(AddContactInitial());
  final dioManager = DioManager();
  final formKey = GlobalKey<FormState>();
  final logger = Logger();
  bool isObscure = true;
  File? profileImage;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final relationController = TextEditingController();
  Future<void> addContact() async {
    if (formKey.currentState!.validate()) {
      emit(AddContactLoadingState());
      try {
        final response = await dioManager.post(
          ApiConstants.AddContact,
          data: FormData.fromMap({
            "Name": nameController.text,
            "Age": ageController.text,
            "Relation": relationController.text,
            if (profileImage != null)
              "ImageUpload": profileImage != null
                  ? MultipartFile.fromFileSync(
                profileImage!.path,
                filename: profileImage!.path.split("/").last,
              )
                  : null,
            "BlindId": CacheHelper.get(key: 'blindId'),

          }),
        );

        if (response.statusCode == 200) {
          emit(AddContactSuccessState());
        } else {
          emit(AddContactFailedState(msg: "${response.data}"));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(AddContactFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(AddContactFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(AddContactNetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(AddContactFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(AddContactNetworkErrorState());
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
}
