part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class GetDataOnceSuccessState extends HomeState {}
class GetDataOnceLoadingState extends HomeState {}
class ListeningSuccessState extends HomeState {}
class ListeningLoadingState extends HomeState {}
