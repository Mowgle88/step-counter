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

  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  Duration? duration;
  late DateTime start;

  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  Duration sensorInterval = SensorInterval.normalInterval;

  @override
  void initState() {
    super.initState();
    requestPermission();
    start = DateTime.now();

    _streamSubscription =
        accelerometerEventStream(samplingPeriod: sensorInterval).listen(
      (AccelerometerEvent event) {
        final now = event.timestamp;
        setState(() {
          x = event.x;
          y = event.y;
          z = event.z;

          duration = now.difference(start);
        });
      },
      onError: (error, stackTrace) {
        print("error: $error");
      },
    );

    steps = 15000;
    goal = 20000;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isPaused = _streamSubscription.isPaused;

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
              ProgressBar(goal: goal, steps: steps, duration: duration),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (isPaused) {
                      _streamSubscription.resume();
                      start = DateTime.now().subtract(duration!);
                    } else {
                      _streamSubscription.pause();
                    }
                  });
                },
                label: Text(
                  isPaused ? "start" : "pause",
                  style: const TextStyle(fontSize: 20),
                ),
                icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.blue.shade100),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
