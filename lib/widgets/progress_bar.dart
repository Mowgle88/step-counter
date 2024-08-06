import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:step_counter/utils/format_time.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.goal,
    required this.steps,
    required this.duration,
  });

  final int goal;
  final int steps;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 120,
      lineWidth: 30.0,
      arcBackgroundColor: Colors.blue,
      progressColor: Colors.green,
      arcType: ArcType.FULL,
      animation: true,
      animationDuration: 1200,
      animateFromLastPercent: true,
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
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Icon(
                Icons.access_time,
                size: 32,
                color: Colors.blueGrey,
              ),
              Text(
                formatTime(duration),
                style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
              const Text(
                "min",
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              )
            ],
          ),
          const SizedBox(width: 60),
          const Column(
            children: [
              Icon(
                Icons.route,
                size: 32,
                color: Colors.blueGrey,
              ),
              Text(
                "3.5",
                style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
              Text(
                "km",
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              )
            ],
          ),
        ],
      ),
      percent: steps / goal,
    );
  }
}
