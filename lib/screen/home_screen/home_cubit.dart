import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:roaia/core/helpers/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final MapController mapController = MapController();
  LatLng ?markerPosition;

  Query dbRef = FirebaseDatabase.instance.ref().child('gps_data');
  Map data = {};


  void getDataOnce() async {
    try {
      emit(GetDataOnceLoadingState());
      DatabaseEvent event = await dbRef.once();
      data = event.snapshot.value as Map;
      final latitude = data[CacheHelper.get(key: 'blindId')]['latitude'];
      final longitude = data[CacheHelper.get(key: 'blindId')]['longitude'];
      markerPosition = LatLng(latitude, longitude);
      print(latitude);
      print(data);
      emit(GetDataOnceSuccessState());
    } catch (e) {
      print('Error getting data once: $e');
    }
  }

  void listenForDataChanges() {
    try {
      emit(ListeningLoadingState());
      dbRef.onValue.listen((event) {
        data = event.snapshot.value as Map;
        final latitude = data[CacheHelper.get(key: 'blindId')]['latitude'];
        final longitude = data[CacheHelper.get(key: 'blindId')]['longitude'];
        markerPosition = LatLng(latitude, longitude);
      });
      emit(ListeningSuccessState());
    }
    catch (e) {
      print('Error on listening data : $e');
    }

//Future<void> _updateLocation() async {
//     // قم بإرسال طلب HTTP للحصول على الموقع الجديد (استخدم مكتبة http)
//     // يجب تعديل الطلب حسب سير العمل الخاص بك
//     final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));
//     if (response.statusCode == 200) {
//       // استخراج الإحداثيات من الاستجابة (يجب تعديلها وفقًا لتنسيق الاستجابة المتوقع)
//       final latitude = double.parse(response.body['latitude']);
//       final longitude = double.parse(response.body['longitude']);
//       setState(() {
//         markerPosition = LatLng(latitude, longitude);
//       });
//     } else {
//       // إدارة الأخطاء هنا
//     }
//   }
    //Timer.periodic(Duration(minutes: 5), (Timer timer) {
//       _updateLocation();
//     });
  }
  void dataChange(){
    getDataOnce();
    listenForDataChanges();
  }
}
