import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';


part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final dioManager = DioManager();
  final logger = Logger();
  bool isObscure = true;
  bool isObscureConfirm = true;
  bool isObscureNewPass = true;
  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }
  changeVisibilityConfirm() {
    isObscureConfirm = !isObscureConfirm;
    emit(ChanceVisibilityState());
  }
  changeVisibilityNewPass() {
    isObscureNewPass = !isObscureNewPass;
    emit(ChanceVisibilityState());
  }
  final formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      emit(ChangePasswordLoadingState());
      try {
        final response = await dioManager.put(
            ApiConstants.changePassword, data: {
          "email": CacheHelper.get(key: 'email'),
          "currentPassword": currentPasswordController.text,
          "newPassword": newPasswordController.text,
          "confirmPassword": confirmPasswordController.text
        });

        if (response.statusCode == 200) {
          emit(ChangePasswordSuccessState());
          CacheHelper.put(
            key: 'access_token',
            value: "${response.data['token']}",
          );
          logger.i(response.data["token"]);
        } else {
          emit(ChangePasswordFailedState(msg: response.data));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(ChangePasswordFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(ChangePasswordFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(ChangePasswordFailedState(msg: "${e.response?.data}"));

        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
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
    emit(ChangePasswordInitial());
    return null;
  }
}
