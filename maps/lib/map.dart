import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition: const CameraPosition(
            target: LatLng(48.8561, 2.2930),
            zoom: 12.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
      ),
    );
  }
}

 // final Set<Marker> _markers = {};

  // void getLocation() async {
  //   // var location = await currentLocation.getLocation();
  //   currentLocation.onLocationChanged.listen(
  //     (LocationData loc) {
  //       // print(currentLocation.getLocation());
  //       _controller?.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //             zoom: 12.0,
  //           ),
  //         ),
  //       );
  //       print(loc.latitude);
  //       print(loc.longitude);
  //       setState(
  //         () {
  //           _markers.add(
  //             Marker(
  //               markerId: const MarkerId('Home'),
  //               position: LatLng(
  //                 loc.latitude ?? 0.0,
  //                 loc.longitude ?? 0.0,
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setState(
  //     () {
  //       getLocation();
  //     },
  //   );
  // }


 // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       child: const Icon(
      //         Icons.location_searching,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         getLocation();
      //         print('hi');
      //       },
      //     ),
      //    const SizedBox(height: 50),
      //   ],
      // ),


                     // ElevatedButton(
          //   onPressed: () async {
          //     geo.Position position = await _getGeoLocationPosition();
          //     location = '${position.latitude},${position.longitude}';
          //     GetAddressFromLatLong(position);
          //   },
          //   child: const Text('current location '),
          // ),
          // FloatingActionButton(
          //   child: const Icon(
          //     Icons.location_searching,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     getRandomLocation(const LatLng(45.32, -122.54), 24);
          //   },
          // ),


     // LatLng getRandomLocation(LatLng point, int radius) {
  //   double x0 = point.latitude;
  //   double y0 = point.longitude;

  //   Random random = Random();

  //   double radiusDegree = radius / 111000;

  //   double u = random.nextDouble();
  //   double v = random.nextDouble();
  //   double w = radiusDegree * sqrt(u);
  //   double t = 2 * pi * v;
  //   double x = w * cos(t);
  //   double y = w * sin(t) * 1.75;

  //   double new_x = x / sin(y0);

  //   double foundlat = new_x + x0;
  //   double foundlon = y + y0;
  //   LatLng randomlatlon = LatLng(foundlat, foundlon);

  //   return randomlatlon;
  // }

  // String location = 'null';
  // String address = 'search';

  // Future<geo.Position> _getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   geo.LocationPermission permission;

  //   serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await geo.Geolocator.openLocationSettings();
  //     return Future.error('enable');
  //   }

  //   permission = await geo.Geolocator.checkPermission();
  //   if (permission == geo.LocationPermission.denied) {
  //     permission = await geo.Geolocator.requestPermission();
  //     if (permission == geo.LocationPermission.denied) {
  //       return Future.error('denied');
  //     }
  //   }

  //   if (permission == geo.LocationPermission.deniedForever) {
  //     return Future.error('denied forever');
  //   }

  //   return await geo.Geolocator.getCurrentPosition(
  //       desiredAccuracy: geo.LocationAccuracy.high);
  // }

  // Future<void> GetAddressFromLatLong(geo.Position position) async {
  //   List<Placemark> placemark =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print(placemark);
  //   Placemark place = placemark[0];
  //   address =
  //       '${place.street},${place.subLocality},${place.locality},${place.postalCode},${place.country}';
  //   setState(() {});
  // }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapData extends StatefulWidget {
//   const MapData({Key? key}) : super(key: key);

//   @override
//   _MapDataState createState() => _MapDataState();
// }

// class _MapDataState extends State<MapData> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(20.5937, 78.9629),
//           zoom: 15,
//         ),
//         // onMapCreated: _onMapCreated,
//         // myLocat
//       ),
//     );
//   }
// }

// import 'dart:math';