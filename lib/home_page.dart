import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int steps;
  late int goal;
  late bool isPlay;

  @override
  void initState() {
    super.initState();
    steps = 15000;
    goal = 20000;
    isPlay = false;
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
              CircularPercentIndicator(
                radius: 120,
                lineWidth: 30.0,
                arcBackgroundColor: Colors.blue,
                progressColor: Colors.green,
                arcType: ArcType.FULL,
                animation: true,
                animationDuration: 1200,
                header: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text('Daily Goal: ${goal.toString()}',
                      style: const TextStyle(fontSize: 30)),
                ),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.personWalking,
                          size: 40,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          steps.toString(),
                          style: const TextStyle(fontSize: 40),
                        )
                      ],
                    ),
                    const Text(
                      "Steps",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                footer: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 32,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          "30:00",
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueGrey),
                        ),
                        Text(
                          "min",
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueGrey),
                        )
                      ],
                    ),
                    SizedBox(width: 60),
                    Column(
                      children: [
                        Icon(
                          Icons.route,
                          size: 32,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          "3.5",
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueGrey),
                        ),
                        Text(
                          "km",
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueGrey),
                        )
                      ],
                    ),
                  ],
                ),
                percent: steps / goal,
              ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
