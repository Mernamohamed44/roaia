import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';
import 'package:roaia/models/blind_info_model.dart';


part 'blind_info_state.dart';

class BlindInfoCubit extends Cubit<BlindInfoStates> {
  BlindInfoCubit() : super(BlindInfoInitial());
  final logger = Logger();
  final dioManager = DioManager();
  BlindInfoModel? BlindInfo;
  String url = '${ApiConstants.blindInfo}/${CacheHelper.get(key: 'blindId')}';

  Future<void> blindInfoData() async {
    emit(BlindInfoLoadingState());
    try {
      final response = await dioManager.get(url);
      if (response.statusCode == 200) {
        BlindInfo = BlindInfoModel.fromJson(response.data);
        emit(BlindInfoSuccessState());
        // CacheHelper.put(
        //   key: 'access_token',
        //   value: "${response.data['token']}",a
        // );
        // CacheHelper.put(
        //   key: 'email',
        //   value: "${response.data['email']}",
        // );
        logger.i(response.data);
      } else {
        emit(BlindInfoFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(BlindInfoFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(BlindInfoFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(BlindInfoFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }
}
