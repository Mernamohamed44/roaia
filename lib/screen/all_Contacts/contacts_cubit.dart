import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/core/networking/api_constants.dart';
import 'package:roaia/core/networking/dio_manager.dart';
import 'package:roaia/models/contacts_model.dart';


part 'Contacts_state.dart';

class ContactsCubit extends Cubit<GetContactsStates> {
  ContactsCubit() : super(ContactsInitial());
  final logger = Logger();
  final dioManager = DioManager();
  List<ContactsModel>contactsList=[];
  String url = '${ApiConstants.getContacts}/${CacheHelper.get(key: 'blindId')}';

  Future<void> getContactData() async {
    emit(GetContactsLoadingState());
    try {
      final response = await dioManager.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data=response.data;
        contactsList = data.map((e) => ContactsModel.fromJson(e)).toList();
        emit(GetContactsSuccessState());
      } else {
        emit(GetContactsFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(GetContactsFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(GetContactsFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        if (e.response!.statusCode == 401) {
          emit(UnAuthorizedState());
        } else {
          emit(GetContactsFailedState(msg: "${e.response?.data}"));
        }
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }
}
