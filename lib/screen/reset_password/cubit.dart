import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';

import 'states.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(context) => BlocProvider.of(context);

  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final dioManager = DioManager();
  final logger = Logger();
  bool isObscure = true;
  bool isObscureConfirm = true;
  bool isRemember = true;

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoadingState());
    try {
      final response = await dioManager.post(
        ApiConstants.resetPass,
        data: FormData.fromMap({
          "Email": email,
          "NewPassword": passwordController.text,
          "ConfirmPassword": rePasswordController.text
        }),
      );

      if (response.statusCode == 200) {
        emit(ResetPasswordSuccessState());
        // CacheHelper.put(
        //   key: 'access_token',
        //   value: "${response.data['token']}",
        // );
        // logger.i(response.data["token"]);
      } else {
        emit(ResetPasswordFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(ResetPasswordFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(ResetPasswordFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(ResetPasswordFailedState(msg: "${e.response?.data}"));

        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }

  //=================================================================
  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }
  changeVisibilityConfirm() {
    isObscureConfirm = !isObscureConfirm;
    emit(ChanceVisibilityState());
  }

  //=================================================================

  @override
  Future<void> close() {
    rePasswordController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
