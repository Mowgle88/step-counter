import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:step_counter/permissions.dart';
import 'package:step_counter/widgets/progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int steps;
  late int goal;
  late bool isPlay;

  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  late StreamSubscription<AccelerometerEvent> _streamSubscription;

  @override
  void initState() {
    super.initState();
    requestPermission();
    startSubscription();

    steps = 15000;
    goal = 20000;
    isPlay = false;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void startSubscription() {
    _streamSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Step Counter"),
        backgroundColor: Colors.blue.shade200,
      ),
      body: SafeArea(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProgressBar(goal: goal, steps: steps),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isPlay = !isPlay;
                  });
                },
                label: Text(
                  isPlay ? "pause" : "start",
                  style: const TextStyle(fontSize: 20),
                ),
                icon: Icon(isPlay ? Icons.pause : Icons.play_arrow),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.blue.shade100),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Accelerometer Data'),
                    Text('X: $x'),
                    Text('Y: $y'),
                    Text('Z: $z'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
