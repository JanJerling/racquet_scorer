import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  Timer? _clockTimer;
  String currentTime = DateFormat('HH:mm').format(DateTime.now());

  @override
  void initState() {
    super.initState();

    // Set the initial time
    setState(() {
      currentTime = DateFormat('HH:mm').format(DateTime.now());
    });

    // Start the clock timer
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.second == 0) {
        setState(() {
          currentTime = DateFormat('HH:mm').format(now);
        });
      }
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                IconButton.filled(
                  onPressed: () {},
                  color: Colors.black,
                  icon: const Icon(Icons.add),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: IconButton.filled(
                    onPressed: () {},
                    color: Colors.black,
                    icon: const Icon(Icons.remove),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.lightBlue.withOpacity(0.7)),
                    ),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Game: 1 "),
                Card(
                  color: Colors.transparent,
                  child: Text(
                    "40 ",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: const Color.fromARGB(255, 143, 187, 223)),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  child: Text(
                    " 15",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: const Color.fromARGB(255, 142, 221, 145)),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.65,
                  child: IconButton.filled(
                    onPressed: () {},
                    color: Colors.black,
                    icon: const Icon(Icons.remove),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.lightGreen.withOpacity(0.5)),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {},
                  color: Colors.black,
                  icon: const Icon(Icons.add),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.green),
                  ),
                ),
              ],
            ),
          ],
        )),
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              currentTime,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
