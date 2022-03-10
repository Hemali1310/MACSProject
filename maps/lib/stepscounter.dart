import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

// String formateData(DateTime d) {
//   return d.toString().substring(0, 19);
// }

class Stepcounter extends StatefulWidget {
  const Stepcounter({Key? key}) : super(key: key);

  @override
  State<Stepcounter> createState() => _StepcounterState();
}

class _StepcounterState extends State<Stepcounter> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  late int _steps;
  int _steps1 = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onPedestiranStatusChanged(PedestrianStatus event) {
    // print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    // print(error);
    setState(() {
      _status = 'not available';
    });
    // print(_status);
  }

  void onStepCount(StepCount event) {
    // print(event);
    setState(() {
      // _steps = _steps - event.steps;
      _steps = event.steps;
    });
  }

  void onStepCountError(error) {
    // print(error);
    setState(() {
      _steps = 0;
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestiranStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Step Counter"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Step taken : ',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '$_steps',
                style: const TextStyle(fontSize: 30),
              ),
              const Text(
                'Steps from 0 : ',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '$_steps1',
                style: const TextStyle(fontSize: 30),
              ),
              const Divider(
                height: 100,
                thickness: 0,
                color: Colors.amber,
              ),
              const Text(
                'Pedesterian status',
                style: TextStyle(fontSize: 30),
              ),
              Icon(
                _status == 'walking'
                    ? Icons.directions_walk
                    : _status == 'stopped'
                        ? Icons.accessibility_new
                        : Icons.error,
                size: 100,
              ),
              Center(
                child: Text(
                  _status,
                  style: _status == 'walking' || _status == 'stopped'
                      ? const TextStyle(fontSize: 30)
                      : const TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
