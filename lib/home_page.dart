import 'package:flutter/material.dart';
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
