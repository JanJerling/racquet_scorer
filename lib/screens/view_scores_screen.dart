import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:racquet_scorer/providers/set_list_provider.dart';

class ViewScoresScreen extends ConsumerWidget {
  const ViewScoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allScores = ref.watch(setListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: ListView.builder(
        itemCount: allScores.length,
        itemBuilder: (context, index) {
          final score = allScores[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Forest: ${score.gameForest}',
                    style: const TextStyle(color: Colors.green)),
                Text('Ocean: ${score.gameOcean}',
                    style: const TextStyle(color: Colors.blue)),
              ],
            ),
          );
        },
      ),
    );
  }
}
