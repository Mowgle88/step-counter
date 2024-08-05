import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.goal,
    required this.steps,
  });

  final int goal;
  final int steps;

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
                style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
              Text(
                "min",
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
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
