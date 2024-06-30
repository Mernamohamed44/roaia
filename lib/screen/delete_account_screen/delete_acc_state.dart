part of 'delete_acc_cubit.dart';

@immutable
abstract class DeleteAccState {}

class DeleteAccInitial extends DeleteAccState {}
class DeleteAccLoadingState extends DeleteAccState {}
class DeleteAccSuccessState extends DeleteAccState {}
class DeleteAccFailState extends DeleteAccState {
  final String  msg;
  DeleteAccFailState( {required this.msg});
}
class NetworkErrorState extends DeleteAccState {}
