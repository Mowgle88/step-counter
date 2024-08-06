import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:step_counter/permissions.dart';
import 'package:step_counter/services/database_service.dart';
import 'package:step_counter/services/key_store.dart';
import 'package:step_counter/widgets/progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService db = DatabaseService();

  bool isPaused = true;
  int goal = 5000;
  int steps = 0;
  Duration? duration;
  late DateTime start;

  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double previousDistacne = 0.0;
  double distance = 0.0;

  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  Duration sensorInterval = SensorInterval.normalInterval;

  @override
  void initState() {
    super.initState();

    requestPermission();

    getData();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void startListening() {
    start =
        DateTime.now().subtract(duration ?? const Duration(milliseconds: 0));

    _streamSubscription = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        final now = event.timestamp;
        setState(() {
          x = event.x;
          y = event.y;
          z = event.z;

          distance = getValue(x, y, z);
          if (distance > 6) {
            steps++;
          }
          duration = now.difference(start);
        });
        setData(steps, duration!);
      },
      onError: (error, stackTrace) {
        print("accelerometerEventStream error: $error");
      },
    );
  }

  void stopListening() {
    _streamSubscription?.cancel();
  }

  void getData() async {
    int goalValue = await db.getInt(KeyStore.goal) ?? 5000;
    int stepsValue = await db.getInt(KeyStore.steps) ?? 0;
    final milliseconds = await db.getInt(KeyStore.duration);
    Duration durationValue = Duration(milliseconds: milliseconds ?? 0);
    setState(() {
      goal = goalValue;
      steps = stepsValue;
      duration = durationValue;
    });
  }

  void setData(int steps, Duration dur) async {
    await db.setInt(KeyStore.steps, steps);
    await db.setInt(KeyStore.duration, dur.inMilliseconds);
  }

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double modDistance = magnitude - previousDistacne;
    setPreviousValue(magnitude);
    return modDistance;
  }

  void setPreviousValue(double distance) async {
    await db.setDouble(KeyStore.prevDistance, distance);
  }

  void getPreviousValue() async {
    double distance = await db.getDouble(KeyStore.prevDistance) ?? 0.0;
    setState(() {
      previousDistacne = distance;
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
              ProgressBar(goal: goal, steps: steps, duration: duration),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (isPaused) {
                      startListening();
                      isPaused = false;
                    } else {
                      stopListening();
                      isPaused = true;
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
