// ignore_for_file: prefer_final_fields, prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/arobj.dart';
import 'package:maps/location.dart';

class Linedata extends StatefulWidget {
  const Linedata({Key? key}) : super(key: key);

  @override
  _LinedataState createState() => _LinedataState();
}

class _LinedataState extends State<Linedata> {
  late GoogleMapController mapController;
  double _originLatitude = 26.48424, _originLongitude = 50.04551;
  late LatLng location;
  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getGeoLocationPosition();
  }

  Future<String> loadjson() async {
    return await rootBundle.loadString('json/maplocation.json');
  }

  Future<void> _onmapcreate(GoogleMapController controller) async {
    String getlocation = await loadjson();
    final response = json.decode(getlocation);
    Locs locs = Locs.fromJson(response);
    List<Locations> locdata = locs.locations;
    for (int i = 0; i < locdata.length; i++) {
      print('====================${locdata[i].latitude}');
      print('--------------------${locdata[i].longitude}');
    }
    setState(() {
      _markers.clear();
      for (final i in locdata) {
        final marker = Marker(
            markerId: MarkerId(i.marketId),
            position: LatLng(i.latitude, i.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            onTap: () async {
              Position position = await _getGeoLocationPosition();
              location = LatLng(
                double.parse(position.latitude.toStringAsFixed(4)),
                double.parse(position.longitude.toStringAsFixed(4)),
              );
              if (LatLng(i.latitude, i.longitude) == location) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TapPage(),
                  ),
                );
              }
            });
        _markers[i.marketId] = marker;
      }
    });
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('enable');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('denied forever');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          builder: (context, snapshot) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude),
                zoom: 0,
              ),
              myLocationEnabled: true,
              // tiltGesturesEnabled: true,
              // compassEnabled: true,
              // scrollGesturesEnabled: true,
              // zoomGesturesEnabled: true,
              onMapCreated: _onmapcreate,
              markers: _markers.values.toSet(),
            );
          },
        ),
      ),
    );
  }
}
//   // _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//   //   MarkerId markerId = MarkerId(id);
//   //   Marker marker =
//   //       Marker(markerId: markerId, icon: descriptor, position: position);
//   //   markers[markerId] = marker;
//   // }

//   _addPolyLine() {
//     PolylineId id = const PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id, color: Colors.red, points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   _getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//         PointLatLng(_originLatitude, _originLongitude),
//         PointLatLng(_destLatitude, _destLongitude),
//         // PointLatLng(_destLatitude, _destLongitude),
//         travelMode: TravelMode.driving,
//         wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     }
//     _addPolyLine();
//   }
// }

// class Linedata extends StatefulWidget {
//   const Linedata({Key? key}) : super(key: key);

//   @override
//   State<Linedata> createState() => _LinedataState();
// }

// class _LinedataState extends State<Linedata> {

//   final Set<Polyline> polyline = {};

//   late GoogleMapController _controller;
//   late List<LatLng> routeCoords;
//   GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onMapCreated: onMapCreated,
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(40.6782, -73.9442),
//           zoom: 14,
//         ),
//         mapType: MapType.normal,
//       ),
//     );
//   }

//   void onMapCreated(GoogleMapController controller){
//     setState(() {
//       _controller = controller;
//     });
//   }
// }


// polylines: Set<Polyline>.of(polylines.values),
              // onCameraMove: (position1) async {
              //   Position position = await _getGeoLocationPosition();
              //   location = LatLng(
              //     double.parse(position.latitude.toStringAsFixed(4)),
              //     double.parse(position.longitude.toStringAsFixed(4)),
              //   );
              //   print('--$location');
              //   // print(locs);
              //   getAddressFromLatLong(position);
              //   // setState(() {
              //   for (int i = 0; i < markerss.length; i++) {
              //     if (markerss[i].position == location) {
              //       markerss[i].onTap;
              //       print('------------${markerss[i].markerId}');
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(
              //       //     builder: (context) => const TapPage(),
              //       //   ),
              //       // );
              //       // print('--------------------------------------------hello');
              //     }
              //   }
              //   // markerss.add(
              //   //   Marker(
              //   //     markerId: markerId,
              //   //     position: position.target,
              //   //   ),
              //   // );
              //   // });
              // },

  //             intilize() {
  //   // ListView.builder(
  //   //   itemCount: locsaefejb.length,
  //   //   itemBuilder: (context, index) {
  //   //     return Container(
  //   //       child: Marker(
  //   //         markerId: const MarkerId('1'),
  //   //         position:
  //   //             LatLng(locsaefejb[index].latitude, locsaefejb[index].longitude),
  //   //         icon: BitmapDescriptor.defaultMarkerWithHue(
  //   //           BitmapDescriptor.hueRed,
  //   //         ),
  //   //         infoWindow: const InfoWindow(title: '1'),
  //   //         onTap: () {
  //   //           print(',,,,,,,,,,,,,,${locsaefejb[index].latitude}');
  //   //           Navigator.push(
  //   //             context,
  //   //             MaterialPageRoute(
  //   //               builder: (context) => const TapPage(),
  //   //             ),
  //   //           );
  //   //         },
  //   //       ) as Widget,
  //   //     );
  //   //   },
  //   // );
  //   // return print('^^^^^^^^^^^^${locsaefejb[1]}');
  //   // return Container(
  //   //   child: Text('${snapshot.data}'),
  //   // );

  //   // locsaefejb.map((e) {
  //   //   return Text(e.latitude.toString());
  //   // // return Marker(
  //   // //   markerId: const MarkerId('1'),
  //   // //   position: const LatLng(44.6569, -63.6243),
  //   // //   infoWindow: const InfoWindow(title: '1'),
  //   // //   icon: BitmapDescriptor.defaultMarkerWithHue(
  //   // //     BitmapDescriptor.hueRed,
  //   // //   ),
  //   // //   onTap: () {
  //   // //     print(',,,,,,,,,,,,,,${e.latitude}');
  //   // //     Navigator.push(
  //   // //       context,
  //   // //       MaterialPageRoute(
  //   // //         builder: (context) => const TapPage(),
  //   // //       ),
  //   // //     );
  //   // //   },
  //   // // );
  //   // });

  //   Marker firstmarker = Marker(
  //     markerId: const MarkerId('2'),
  //     position: const LatLng(37.7858, -122.4064),
  //     infoWindow: const InfoWindow(title: '2'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(
  //       BitmapDescriptor.hueRed,
  //     ),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const TapPage(),
  //         ),
  //       );
  //     },
  //   );

  //   Marker secondmarker = Marker(
  //     markerId: const MarkerId('2'),
  //     position: const LatLng(37.7858, -122.4064),
  //     infoWindow: const InfoWindow(title: '2'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(
  //       BitmapDescriptor.hueRed,
  //     ),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const TapPage(),
  //         ),
  //       );
  //     },
  //   );

  //   Marker thirdmarker = Marker(
  //     markerId: const MarkerId('3'),
  //     position: const LatLng(44.6505, -63.6051),
  //     infoWindow: const InfoWindow(title: '3'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(
  //       BitmapDescriptor.hueRed,
  //     ),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const TapPage(),
  //         ),
  //       );
  //     },
  //   );

  //   Marker fourthmarker = Marker(
  //     markerId: const MarkerId('4'),
  //     position: const LatLng(44.6691, -63.6158),
  //     infoWindow: const InfoWindow(title: '4'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(
  //       BitmapDescriptor.hueRed,
  //     ),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const TapPage(),
  //         ),
  //       );
  //     },
  //   );

  //   // markerss.

  //   markerss.add(firstmarker);
  //   markerss.add(secondmarker);
  //   markerss.add(thirdmarker);
  //   markerss.add(fourthmarker);
  //   setState(() {});
  // }

// Future<double?> locations() async {
  //   String getlocation = await loadjson();
  //   final response = json.decode(getlocation);

  //   Locs locs = Locs.fromJson(response);
  //   List<Locations> locdata = locs.locations;
  //   for (int i = 0; i < locdata.length; i++) {
  //     print('====================$locdata');
  //     print('--------------------${locdata[i].longitude}');
  //   }

  //   setState(() {
  //     locsaefejb = locs.locations;
  //   });
  // }


    /// origin marker
    // _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
    //     BitmapDescriptor.defaultMarker);

    // /// destination marker
    // _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
    //     BitmapDescriptor.defaultMarkerWithHue(90));
    // _getPolyline();

     // Future<void> getAddressFromLatLong(Position position) async {
  //   List<Placemark> placemark =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   Placemark place = placemark[0];
  //   address =
  //       '${place.street},${place.subLocality},${place.locality},${place.postalCode},${place.country}';
  //   setState(() {});
  // }


   // void _onMapCreated(GoogleMapController controller) async {
  //   mapController = controller;
  // }

   // Map<MarkerId, Marker> markers = {};
  // Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  // String googleAPiKey = "";
  // List<Marker> markerss = [];

    // locations();
    // intilize();