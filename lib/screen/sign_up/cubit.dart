import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';


import 'controller.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final dioManager = DioManager();
  final formKey = GlobalKey<FormState>();
  final controllers = RegisterControllers();
  final logger = Logger();
  bool isObscure = true;
  File? imageFileCropper;

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      try {
        final response = await dioManager.post(
          ApiConstants.register,
          data: FormData.fromMap({
            "FirstName": controllers.firstNameController.text,
            "LastName": controllers.lastNameController.text,
            "Username": controllers.userNameController.text,
            "BlindId": barcode,
            "Email": controllers.emailController.text,
            "Password": controllers.passwordController.text,
            "ImageUrl": imageFileCropper != null
                ? MultipartFile.fromFileSync(
                    imageFileCropper!.path,
                    filename: imageFileCropper!.path.split("/").last,
                  )
                : null,
            "IsAgree": "true",
          }),
        );

        if (response.statusCode == 200) {
          emit(RegisterSuccessState());
          CacheHelper.put(
            key: 'access_token',
            value: "${response.data['token']}",
          );
          logger.i(response.data["token"]);
        } else {
          emit(RegisterFailedState(msg: "${response.data}"));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(RegisterFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(RegisterFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(RegisterNetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(RegisterFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(RegisterNetworkErrorState());
    }
    logger.e(e);
  }

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }

  String patternPass =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password Field required';
    }
    RegExp regex = RegExp(patternPass);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.';
    }
    emit(UploadImageStates());
    return null;
  }

  String patternEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email Field required';
    }
    RegExp regex = RegExp(patternEmail);
    if (!regex.hasMatch(value)) {
      return 'Email should start with letters or numbers, followed by @, and a valid domain name without special characters!';
    }
    emit(UploadImageStates());
    return null;
  }

  String invalidGuidRegex =
      r'Invalid Glasses ID [A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{6}! and GUID';
  String? validateGuid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Glasses ID  should be XXXXXXXX-XXXX-XXXX-XXXX-XXXXXX';
    }
    // RegExp regex = RegExp(invalidGuidRegex);
    // if (!regex.hasMatch(value)) {
    //   return 'Glasses ID  should be XXXXXXXX-XXXX-XXXX-XXXX-XXXXXX ';
    // }
    emit(ValidateGuidStates());
    return null;
  }

  chooseLicenseImage() {
    ImagePicker.platform.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFileCropper = File(value.path);
        emit(UploadImageStates());
      }
    });
  }

  String barcode = '';
  TextEditingController glassesId=TextEditingController();
  Future scanBarcode() async {
    try {
      barcode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.BARCODE);

      debugPrint(barcode);
    } on PlatformException {
      barcode = 'Failed to get ';
    }
    emit(ScanBarcode());
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
