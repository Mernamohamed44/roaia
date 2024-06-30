import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';


import 'states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInitialState());

  final dioManager = DioManager();
  final logger = Logger();
  final controllerOTP=TextEditingController();

  bool isFull =false;
  void full(){
    isFull = true;
    emit(ChangeFullState());
  }  void unFull(){
    isFull = false;
    emit(ChangeFullState());
  }

  Future<void> otp({required String email, required String fullOtp}) async {
    emit(OtpLoadingState());
    try {
      final response = await dioManager.post(
        ApiConstants.otbVerification,
        data: {
          "email": email,
          "otpCode": fullOtp,
        },
      );

      if (response.statusCode == 200) {
        emit(OtpSuccessState());
      } else {
        emit(OtpFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(OtpFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(OtpFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(OtpFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }

  @override
  Future<void> close() {
    controllerOTP.dispose();
    return super.close();
  }
}
