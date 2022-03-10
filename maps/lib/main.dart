// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:maps/arobj.dart';
import 'package:maps/currentlocation.dart';
import 'package:maps/map.dart';
import 'package:maps/polyline.dart';
import 'package:maps/stepscounter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              // print('hi');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TapPage(),
                ),
              );
              // const MapData();
            },
            child: const Icon(Icons.camera),
          ),
          RaisedButton(
            onPressed: () {
              // print('hello');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapScreen(),
                ),
              );
              // ARObj();
            },
            child: const Text('Map'),
          ),
          RaisedButton(
            onPressed: () {
              // print('hello');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Stepcounter(),
                ),
              );
              // ARObj();
            },
            child: const Text('Steps'),
          ),
          RaisedButton(
            onPressed: () {
              // print('hello');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Linedata(),
                ),
              );
              // ARObj();
            },
            child: const Text('Line'),
          ),
          // RaisedButton(
          //   onPressed: () {
          //     // print('hello');
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const CurrentLocation(),
          //       ),
          //     );
          //     // ARObj();
          //   },
          //   child: const Text('Current Location'),
          // ),
        ],
      ),
    );
  }
}

 // const GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(20.5937, 78.9629),
          //     zoom: 15,
          //   ),
          //   // onMapCreated: _onMapCreated,
          //   // myLocationEnabled: true,
          // ),

   //  Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),

 // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  // late GoogleMapController _controller;
  // final Location _location = Location();

  // void _onMapCreated(GoogleMapController _cntlr) {
  //   _controller = _cntlr;
  //   _location.onLocationChanged.listen((l) {
  //     _controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
  //       ),
  //     );
  //   });
  // }

  // late ARKitController arKitController;

  // @override
  // void dispose() {
  //   arKitController.dispose();
  //   super.dispose();
  // }

  // Widget arfun() {
  //   return ARKitSceneView(
  //     onARKitViewCreated: onARKitViewCreated,
  //   );
  // }

  // void onARKitViewCreated(ARKitController arKitController) {
  //   this.arKitController = arKitController;
  //   final node = ARKitNode(
  //     geometry: ARKitSphere(radius: 0.1),
  //     position: Vector3(0, 0, -0.5),
  //   );
  //   this.arKitController.add(node);
  // }

  // Widget appdata() {
  //   return const GoogleMap(
  //     initialCameraPosition: CameraPosition(
  //       target: LatLng(20.5937, 78.9629),
  //       zoom: 15,
  //     ),
  //     // onMapCreated: _onMapCreated,
  //     // myLocationEnabled: true,
  //   );
  // }


// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   State<MapScreen> createState() => MapScreenState();
// }

// class MapScreenState extends State<MapScreen> {
//   LatLng initPosition = const LatLng(0, 0); //initial Position cannot assign null values
//   LatLng currentLatLng= const LatLng(0.0, 0.0); //initial currentPosition values cannot assign null values
//   LocationPermission permission = LocationPermission.denied; //initial permission status
//   final Completer<GoogleMapController> _controller = Completer();

//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//     checkPermission();
//   }

//   //checkPersion before initialize the map
//   void checkPermission() async{
//     permission = await Geolocator.checkPermission();
//   }

//   // get current location
//   void getCurrentLocation() async{
//     await Geolocator.getCurrentPosition().then((currLocation) {
//       setState(() {
//         currentLatLng =
//           LatLng(currLocation.latitude, currLocation.longitude);
//       });
//     });
//   }

//   //call this onPress floating action button
//   void _currentLocation() async {
//     final GoogleMapController controller = await _controller.future;
//     getCurrentLocation();
//     controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         bearing: 0,
//         target: currentLatLng,
//         zoom: 18.0,
//       ),
//     ));
//   }

//   //Check permission status and currentPosition before render the map
//   bool checkReady(LatLng? x, LocationPermission? y) {
//     if (x == initPosition || y == LocationPermission.denied || y == LocationPermission.deniedForever) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(permission);
//     print("Current Location --------> " +
//         currentLatLng.latitude.toString() +
//         " " +
//         currentLatLng.longitude.toString());
//     return MaterialApp(
//       //remove debug banner on top right corner
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         //ternary operator use for conditional rendering
//         body: checkReady(currentLatLng, permission)
//             ? const Center(child: CircularProgressIndicator())
//         //Stack : place floating action button on top of the map
//             : Stack(children: [
//                 GoogleMap(
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   zoomControlsEnabled: false,
//                   mapType: MapType.normal,
//                   initialCameraPosition: CameraPosition(target: currentLatLng),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                 ),
//                 //Positioned : use to place button bottom right corner
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Container(
//                     margin: const EdgeInsets.all(15),
//                     child: FloatingActionButton(
//                         onPressed: _currentLocation,
//                         child: const Icon(Icons.location_on)),
//                   ),
//                 ),
//               ]),
//       ),
//     );
//   }
// }
