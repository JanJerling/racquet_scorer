import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'golden_point_provider.dart';

class ScoreScreen extends ConsumerStatefulWidget {
  const ScoreScreen({super.key});

  @override
  ConsumerState<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends ConsumerState<ScoreScreen> {
  Timer? _clockTimer;
  String currentTime = DateFormat('HH:mm').format(DateTime.now());
  int oceanScore = 0;
  int forestScore = 0;
  final List<String> scoresTraditional = ["0", "15", "30", "40", "AD"];
  final List<String> scoresGoldenPoint = ["0", "15", "30", "40"];
  late List<String> scores;
  bool isGoldenPoint = false;

  @override
  void initState() {
    super.initState();

    // Set the initial time
    setState(() {
      currentTime = DateFormat('HH:mm').format(DateTime.now());
    });

    // Initialize scores
    scores = isGoldenPoint ? scoresTraditional : scoresGoldenPoint;

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

  void pointsCalculator(String team) {
    print(team);
    print(forestScore);
    print(oceanScore);
    if (team == "forest") {
      setState(() {
        if (isGoldenPoint) {
          if (forestScore == 3 && oceanScore == 3) {
            endGameProcess(team);
          } else {
            forestScore++;
          }
        } else if (forestScore == 3 && oceanScore == 4) {
          oceanScore--;
        } else if (forestScore == 4 && oceanScore == 3) {
          endGameProcess(team);
        } else {
          forestScore++;
        }
      });
    }
    if (team == "ocean") {
      setState(() {
        if (isGoldenPoint) {
          if (forestScore == 3 && oceanScore == 3) {
            endGameProcess(team);
          } else {
            oceanScore++;
          }
        } else if (oceanScore == 3 && forestScore == 4) {
          forestScore--;
        } else if (oceanScore == 4 && forestScore == 3) {
          endGameProcess(team);
        } else {
          oceanScore++;
        }
      });
    }
  }

  void endGameProcess(String team) {
    print("End Game $team");
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isGoldenPoint = ref.watch(goldenPointProvider);
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
                      onPressed: () {
                        setState(() {
                          forestScore--;
                        });
                      },
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
                      scores[forestScore],
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
                    onPressed: () => pointsCalculator("forest"),
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
                      onPressed: () {
                        setState(() {
                          oceanScore--;
                        });
                      },
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
                      scores[oceanScore],
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
                    onPressed: () => pointsCalculator("ocean"),
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
