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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Set 1"),
                SizedBox(width: 4),
                Text("Game 1"),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Transform.scale(
                    scale: 0.65,
                    child: IconButton.filled(
                      onPressed: () {},
                      color: Colors.black,
                      icon: const Icon(Icons.remove),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.green),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Card(
                    color: Colors.transparent,
                    child: Text(
                      "40",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: const Color.fromARGB(255, 142, 221, 145)),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: IconButton.filled(
                    onPressed: () {},
                    color: Colors.black,
                    icon: const Icon(Icons.add),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.green),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Transform.scale(
                    scale: 0.65,
                    child: IconButton.filled(
                      onPressed: () {},
                      color: Colors.black,
                      icon: const Icon(Icons.remove),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Card(
                    color: Colors.transparent,
                    child: Text(
                      "15",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: const Color.fromARGB(255, 143, 187, 223)),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: IconButton.filled(
                    onPressed: () {},
                    color: Colors.black,
                    icon: const Icon(Icons.add),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
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
