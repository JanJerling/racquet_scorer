import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:racquet_scorer/providers/games_score_provider.dart';

class TopScoreBar extends ConsumerWidget {
  const TopScoreBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // retrieve set count
    var setCount = ref.watch(gamesScoreProvider).set;
    var gamesForest = ref.watch(gamesScoreProvider).gameForest;
    var gamesOcean = ref.watch(gamesScoreProvider).gameOcean;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Set $setCount : "),
        const SizedBox(width: 8),
        Text(
          "$gamesForest",
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 4),
        const Text("|", style: TextStyle(fontSize: 18)),
        const SizedBox(width: 4),
        Text(
          "$gamesOcean",
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 36),
      ],
    );
  }
}
