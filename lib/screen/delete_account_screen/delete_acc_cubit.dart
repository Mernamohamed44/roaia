import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';

part 'delete_acc_state.dart';

class DeleteAccCubit extends Cubit<DeleteAccState> {
  DeleteAccCubit() : super(DeleteAccInitial());
  final dioManager = DioManager();
  final logger = Logger();
  String deleteAccount =
      '${ApiConstants.DeleteAccount}/${CacheHelper.get(key: 'id')}';
  Future<void> deleteAcc() async {
    emit(DeleteAccLoadingState());
    try {
      final response = await dioManager.post(
        deleteAccount,
      );

      if (response.statusCode == 200) {
        emit(DeleteAccSuccessState());
      } else {
        emit(DeleteAccFailState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(DeleteAccFailState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }
  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(DeleteAccFailState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(DeleteAccFailState(msg: "${e.response?.data}"));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }
}
