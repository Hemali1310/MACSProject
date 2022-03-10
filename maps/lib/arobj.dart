import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TapPage extends StatefulWidget {
  const TapPage({Key? key}) : super(key: key);

  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  late ARKitController arkitController;
  ARKitSphere? sphere;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Tap Gesture Sample'),
        ),
        body: ARKitSceneView(
          enableTapRecognizer: true,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodeTap = (nodes) => onNodeTapHandler(nodes);

    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.color(Colors.yellow),
    );
    sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );

    final node = ARKitNode(
      name: 'sphere',
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.5),
    );
    this.arkitController.add(node);
  }

  void onNodeTapHandler(List<String> nodesList) {
    // final name = nodesList.first;
    // final color =
        // (sphere!.materials.value!.first.diffuse as ARKitMaterialColor).color ==
        //         Colors.yellow
        //     ? sphere!.materials.value!.first.transparent
        //     : Colors.yellow;
    (sphere!.materials.value!.first.diffuse as ARKitMaterialColor).color ==
            Colors.yellow;
    sphere!.materials.value = [
      ARKitMaterial(
        transparency: 0,
      )
    ];
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        content:  Text('You have collected the object'),
      ),
    );
  }

  // void onNodeTapHandler(List<String> nodesList) {
  //   final name = nodesList.first;
  //   final color =
  //       // (sphere!.materials.value!.first.diffuse as ARKitMaterialColor).color ==
  //       //         Colors.yellow
  //       //     ? sphere!.materials.value!.first.transparent
  //       //     : Colors.yellow;
  //   (sphere!.materials.value!.first.diffuse as ARKitMaterialColor).color ==
  //           Colors.yellow
  //       ? Colors.blue
  //       : Colors.yellow;
  //   sphere!.materials.value = [
  //     ARKitMaterial(
  //       diffuse: ARKitMaterialProperty.color(color),
  //     )
  //   ];
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: Text('You tapped on $name'),
  //     ),
  //   );
  // }
}

// import 'package:flutter/material.dart';
// import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:vector_math/vector_math_64.dart';

// class ARObj extends StatefulWidget {
//   const ARObj({ Key? key }) : super(key: key);

//   @override
//   _ARObjState createState() => _ARObjState();
// }

// class _ARObjState extends State<ARObj> {

//   late ARKitController arKitController;

//   @override
//   void dispose() {
//     arKitController.dispose();
//     super.dispose();
//   }

// void onARKitViewCreated(ARKitController arKitController) {
//     this.arKitController = arKitController;
//     final node = ARKitNode(
//       geometry: ARKitSphere(radius: 0.1),
//       position: Vector3(0, 0, -0.5),
//     );
//     this.arKitController.add(node);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ARKitSceneView(
//         onARKitViewCreated: onARKitViewCreated,
//       ),
//     );
//   }
// }