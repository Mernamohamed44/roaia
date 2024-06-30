import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';
import 'package:roaia/models/notofications_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitial());
  final dioManager = DioManager();
  final formKey = GlobalKey<FormState>();
  final logger = Logger();
  List<NotificationsModel> notificationsList = [];
  String url =
      '${ApiConstants.getNotifications}/${CacheHelper.get(key: 'blindId')}';
  Future<void> getNotifications() async {
    emit(NotificationsLoadingState());
    try {
      final response = await dioManager.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        notificationsList =
            data.map((e) => NotificationsModel.fromJson(e)).toList();
        emit(NotificationsSuccessState());
        logger.i(response.data);
      } else {
        emit(NotificationsFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(NotificationsFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }
  String deleteNotifications =
      '${ApiConstants.DeleteNotifications}/${CacheHelper.get(key: 'blindId')}';
  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(NotificationsFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(NotificationsFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }
  Future<void> DeleteNotifications() async {
    emit(DeleteNotificationsLoadingState());
    try {
      final response = await dioManager.post(
        deleteNotifications,
      );

      if (response.statusCode == 200) {
        emit(DeleteNotificationsSuccessState());
      } else {
        emit(DeleteNotificationsFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(DeleteNotificationsFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }
  
  Color? notificationsTypeColor({required String type}) {
    switch (type) {
      case 'Warning':
        return const Color(0xffEEFFD9);
      case 'Critical':
        return const Color(0xffFFD9DD);
      case 'Normal':
        return const Color(0xffC3DAFF);
      default:
        return Colors.black;
    }
  }Color? notificationsTypeIconColor({required String type}) {
    switch (type) {
      case 'Warning':
        return const Color(0xff6EB912);
      case 'Critical':
        return const Color(0xffE20018);
      case 'Normal':
        return const Color(0xff1363DF);
      default:
        return Colors.black;
    }
  }

}
