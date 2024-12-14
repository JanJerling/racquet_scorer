import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:racquet_scorer/providers/games_score_provider.dart';
import 'package:racquet_scorer/screens/score_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:racquet_scorer/providers/set_list_provider.dart';
import 'package:racquet_scorer/providers/tie_break_provider.dart';
import 'view_scores_screen.dart';

class OptionsScreen extends ConsumerStatefulWidget {
  const OptionsScreen({super.key});

  @override
  ConsumerState<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends ConsumerState<OptionsScreen> {
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
    var forest = ref.watch(gamesScoreProvider).gameForest;
    var ocean = ref.watch(gamesScoreProvider).gameOcean;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if ((forest == 6 && ocean < 5) ||
                        (ocean == 6 && forest < 5) ||
                        (forest == 7 && ocean == 5) ||
                        (ocean == 7 && forest == 5) ||
                        (forest == 7 && ocean == 6) ||
                        (ocean == 7 && forest == 6)) {
                      ref
                          .read(setListProvider.notifier)
                          .addMatch(ref.watch(gamesScoreProvider));
                      ref.read(gamesScoreProvider.notifier).newSet();
                    } else if (forest == 6 && ocean == 6) {
                      ref.read(tieBreakProvider.notifier).toggleTieBreak();
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const ScoreScreen()),
                        (Route<dynamic> route) => false);
                  },
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    minimumSize: WidgetStatePropertyAll(Size(150, 50)),
                  ),
                  child: const Text("Next Game"),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const ViewScoresScreen()));
                  },
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    minimumSize: WidgetStatePropertyAll(Size(150, 50)),
                  ),
                  child: const Text("View Scores"),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      currentTime,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
