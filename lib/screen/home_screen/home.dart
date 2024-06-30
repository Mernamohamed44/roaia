import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:roaia/screen/home_screen/components/custom_drawer.dart';
import 'package:roaia/screen/home_screen/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    cubit.getDataOnce();
    //  cubit.dataChange();
    // cubit.listenForDataChanges();
    // الإحداثيات الابتدائية
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetDataOnceLoadingState) {
            return Center(
                child:
                    CircularProgressIndicator(color: const Color(0xff2C67FF)));
          }
          return FlutterMap(
            mapController: cubit.mapController,
            options: MapOptions(
              center: cubit.markerPosition,
              zoom: 10.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: cubit.markerPosition!,
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      endDrawer: CustomDrawer(),
    );
  }
}
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   Query dbRef = FirebaseDatabase.instance.ref().child('gps_data');
//
//   Widget listItem({required Map location}) {
//     print("location:$location");
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 110,
//       color: Colors.amberAccent,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             location['latitude'].toString(),
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             location['longitude'].toString(),
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetching data'),
//         ),
//         body: Container(
//           height: double.infinity,
//           child: FirebaseAnimatedList(
//             query: dbRef,
//             itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
//
//               Map location = snapshot.value as Map;
//               print("cc:$location");
//
//               location['key'] = snapshot.key;
//
//               print("zz:${snapshot.key}");
//
//               return listItem(location: location);
//
//             },
//           ),
//         )
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

// class HomeScreen extends StatefulWidget {
//   final String glassesId;
//
//   HomeScreen({required this.glassesId});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late DatabaseReference _gpsRef;
//
//   double? _latitude;
//   double? _longitude;
//
//   @override
//   void initState() {
//     super.initState();
//     _gpsRef = FirebaseDatabase.instance.ref().child('gps_data').child(widget.glassesId);
//     _listenToGpsData();
//   }
//
//   void _listenToGpsData() {
//     _gpsRef.onValue.listen((DatabaseEvent event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;
//       if (data != null) {
//         setState(() {
//           _latitude = data['latitude'];
//           _longitude = data['longitude'];
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GPS Data for ${widget.glassesId}'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Latitude: ${_latitude ?? "Loading..."}'),
//             Text('Longitude: ${_longitude ?? "Loading..."}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
