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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("row1"),
                IconButton.filled(
                    onPressed: () {}, icon: const Icon(Icons.add)),
                IconButton.filled(
                    onPressed: () {}, icon: const Icon(Icons.remove))
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("row2"),
                Card(
                  child: Text("40"),
                ),
                Card(
                  child: Text("15"),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("row3"),
                IconButton.filled(
                    onPressed: () {}, icon: const Icon(Icons.add)),
                IconButton.filled(
                    onPressed: () {}, icon: const Icon(Icons.remove))
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
