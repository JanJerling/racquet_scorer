import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:racquet_scorer/providers/games_score_provider.dart';
import 'package:racquet_scorer/providers/set_list_provider.dart';
import 'package:racquet_scorer/screens/exit_screen.dart';
import 'package:racquet_scorer/screens/options_screen.dart';
import 'package:racquet_scorer/providers/tie_break_provider.dart';
import 'package:racquet_scorer/widgets/top_score_bar.dart';

import '../providers/golden_point_provider.dart';

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
  final List<String> scoresTraditional = ["  0", "15", "30", "40", "AD"];
  final List<String> scoresGoldenPoint = ["  0", "15", "30", "40"];
  late List<String> scores;
  bool isTieBreak = false;
  bool isGoldenPoint = false;
  int setCount = 1;
  int gamesOcean = 0;
  int gamesForest = 0;
  int tieBreakDuration = 7;

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

  void pointsCalculator(String team) {
    if (isTieBreak) {
      if (team == "forest") {
        setState(() {
          if (forestScore >= tieBreakDuration - 1 &&
              (forestScore - oceanScore) > 0) {
            endGameProcess(team);
          } else {
            forestScore++;
          }
        });
      }
      if (team == "ocean") {
        setState(() {
          if (oceanScore >= tieBreakDuration - 1 &&
              (oceanScore - forestScore) > 0) {
            endGameProcess(team);
          } else {
            oceanScore++;
          }
        });
      }
    } else {
      if (team == "forest") {
        setState(() {
          if (isGoldenPoint) {
            if (forestScore == 3) {
              endGameProcess(team);
            } else {
              forestScore++;
            }
          } else {
            if (forestScore == 3 && oceanScore == 4) {
              oceanScore--;
            } else if (forestScore == 4 && oceanScore == 3) {
              endGameProcess(team);
            } else {
              if (forestScore == 3 && oceanScore < 3) {
                endGameProcess(team);
              } else {
                forestScore++;
              }
            }
          }
        });
      }
      if (team == "ocean") {
        setState(() {
          if (isGoldenPoint) {
            if (oceanScore == 3) {
              endGameProcess(team);
            } else {
              oceanScore++;
            }
          } else {
            if (oceanScore == 3 && forestScore == 4) {
              forestScore--;
            } else if (oceanScore == 4 && forestScore == 3) {
              endGameProcess(team);
            } else {
              if (oceanScore == 3 && forestScore < 3) {
                endGameProcess(team);
              } else {
                oceanScore++;
              }
            }
          }
        });
      }
    }
  }

  void endGameProcess(String team) {
    ref.read(gamesScoreProvider.notifier).addGame(team);
    ref
        .read(setListProvider.notifier)
        .updateMatch(ref.watch(gamesScoreProvider));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const OptionsScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // is Golden Point?
    isGoldenPoint = ref.watch(goldenPointProvider);
    // Check if it is a tie break
    isTieBreak = ref.watch(tieBreakProvider).isBreaker;
    tieBreakDuration = ref.watch(tieBreakProvider).tieDuration;
    // retrieve set count
    setCount = ref.watch(gamesScoreProvider).set;
    gamesForest = ref.watch(gamesScoreProvider).gameForest;
    gamesOcean = ref.watch(gamesScoreProvider).gameOcean;
    // Initialize scores list
    scores = isGoldenPoint ? scoresGoldenPoint : scoresTraditional;
    //body
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const ExitScreen()));
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          // stack for clock and main screen
          children: [
            // main screen column
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // set and game counter row
                const TopScoreBar(),
                // Scores Row
                Row(
                  children: [
                    // undo scores column
                    Expanded(
                      flex: 8,
                      child: Container(
                        alignment: const Alignment(0.4, 0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: IconButton(
                                onPressed: () {
                                  if (forestScore > 0) {
                                    setState(() {
                                      forestScore--;
                                    });
                                  }
                                },
                                padding: EdgeInsets.zero,
                                color: Colors.black,
                                icon: const Icon(Icons.remove),
                                iconSize: 20,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.green.withOpacity(0.8)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: IconButton(
                                onPressed: () {
                                  if (oceanScore > 0) {
                                    setState(() {
                                      oceanScore--;
                                    });
                                  }
                                },
                                padding: EdgeInsets.zero,
                                color: Colors.black,
                                icon: const Icon(Icons.remove),
                                iconSize: 20,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.blue.withOpacity(0.8)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // add score
                    Expanded(
                      flex: 20,
                      child: Column(
                        children: [
                          // Forest scorer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Card(
                                  color: Colors.transparent,
                                  child: Text(
                                    isTieBreak
                                        ? forestScore.toString()
                                        : scores[forestScore],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            color: const Color.fromARGB(
                                                255, 142, 221, 145)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 52,
                                height: 52,
                                child: IconButton(
                                  onPressed: () => pointsCalculator("forest"),
                                  color: Colors.black,
                                  icon: const Icon(Icons.add),
                                  iconSize: 30,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.green),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18)
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Ocean scorer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Card(
                                  color: Colors.transparent,
                                  child: Text(
                                    isTieBreak
                                        ? oceanScore.toString()
                                        : scores[oceanScore],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: const Color.fromARGB(
                                              255, 143, 187, 223),
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 52,
                                height: 52,
                                child: IconButton(
                                  onPressed: () => pointsCalculator("ocean"),
                                  color: Colors.black,
                                  icon: const Icon(Icons.add),
                                  iconSize: 30,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
