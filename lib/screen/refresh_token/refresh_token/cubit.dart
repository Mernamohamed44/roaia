import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';


import 'states.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenStates> {
  RefreshTokenCubit() : super(RefreshTokenInitialState());

  static RefreshTokenCubit get(context) => BlocProvider.of(context);

  final dioManager = DioManager();
  final logger = Logger();
  String refreshToken = CacheHelper.get(key: 'refreshToken');
  Future<void> getToken() async {
    print('nnnnnnnnnnnnnnnnnnnnn');
    emit(RefreshTokenLoadingState());

    try {
      print('ffffffffffffffffffff');

      final response = await dioManager.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': refreshToken},
        // json: {
        //   "token": "${CacheHelper.get(key: "refresh_token") ?? ""}",
        // },
      );
      print('ssssssssssssssssssssss');

      if (response.statusCode == 200) {
        emit(RefreshTokenSuccessState());
        CacheHelper.put(
          key: 'access_token',
          value: "${response.data['token']}",
        );
        CacheHelper.put(
          key: 'refreshToken',
          value: "${response.data['refreshToken']}",
        );
        logger.i(response.data['token']);
      } else {
        emit(RefreshTokenFailedState());
      }
    } on DioException catch (e) {
      handleDioException(e);
      logger.e(e);
    } catch (e) {
      emit(RefreshTokenFailedState());
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    if (e.type == DioExceptionType.cancel) {
      emit(RefreshTokenFailedState());
    } else if (e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      emit(RefreshTokenErrorNetworkState());
    } else if (e.type == DioExceptionType.badResponse) {
      emit(RefreshTokenFailedState());
    } else {
      emit(RefreshTokenErrorNetworkState());
    }
    logger.e(e);
  }
}
