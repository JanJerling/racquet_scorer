import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:racquet_scorer/providers/set_list_provider.dart';

class ViewScoresScreen extends ConsumerStatefulWidget {
  const ViewScoresScreen({super.key});

  @override
  ConsumerState<ViewScoresScreen> createState() => _ViewScoresScreenState();
}

class _ViewScoresScreenState extends ConsumerState<ViewScoresScreen> {
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
    var allScores = ref.watch(setListProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Set"),
                  const SizedBox(width: 12),
                  Text("|", style: TextStyle(color: Colors.grey[800])),
                  const SizedBox(width: 12),
                  const Text("Forest", style: TextStyle(color: Colors.green)),
                  const SizedBox(width: 16),
                  const Text("Ocean", style: TextStyle(color: Colors.blue)),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: allScores.length,
                  itemBuilder: (context, index) {
                    final score = allScores[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${score.set}',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 18),
                        Text(
                          "|",
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 18),
                        ),
                        const SizedBox(width: 26),
                        Text(
                          '${score.gameForest}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 45),
                        Text(
                          '${score.gameOcean}',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
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
