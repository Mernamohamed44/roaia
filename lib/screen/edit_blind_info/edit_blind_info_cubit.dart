import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';


part 'edit_blind_info_state.dart';

class EditBlindInfoCubit extends Cubit<EditBlindInfoStates> {
  EditBlindInfoCubit() : super(EditBlindInfoInitial());
  final dioManager = DioManager();
  final formKey = GlobalKey<FormState>();
  final logger = Logger();
  TextEditingController blindNameController = TextEditingController();
  TextEditingController blindAgeController = TextEditingController();
  String? blindGender;
  String blindId = CacheHelper.get(key: 'blindId');
  File? profileImage;
  TextEditingController blindDiseasesController = TextEditingController();
  int itemCount = 1;

  Future<void> EditBlindInfo(
      {required String gender, required List<String> Diseases}) async {
    if (formKey.currentState!.validate()) {
      emit(EditBlindLoadingState());
      try {
        final response = await dioManager.put(
          ApiConstants.editBlind,
          data: FormData.fromMap({
            'Id': blindId,
            "FullName": blindNameController.text,
            "Age": blindAgeController.text,
            "Gender": gender,
            if (profileImage != null)
              "ImageUpload": profileImage != null
                  ? MultipartFile.fromFileSync(
                      profileImage!.path,
                      filename: profileImage!.path.split("/").last,
                    )
                  : null,

              'Diseases':Diseases
          }),
        );

        if (response.statusCode == 200) {
          emit(EditBlindSuccessState());
        } else {
          emit(EditBlindFailedState(msg: "${response.data}"));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(EditBlindFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(EditBlindFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(EditBlindNetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(EditBlindFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(EditBlindNetworkErrorState());
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
