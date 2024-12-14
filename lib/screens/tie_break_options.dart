import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:racquet_scorer/screens/exit_screen.dart';
import 'package:racquet_scorer/screens/score_screen.dart';
import 'package:racquet_scorer/providers/tie_break_provider.dart';

class TieBreakOptions extends ConsumerStatefulWidget {
  const TieBreakOptions({super.key});

  @override
  ConsumerState<TieBreakOptions> createState() => _TieBreakOptionsState();
}

class _TieBreakOptionsState extends ConsumerState<TieBreakOptions> {
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const ExitScreen()));
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tie-break options:"),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(tieBreakProvider.notifier)
                          .setTieBreakDuration(7);
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
                    child: const Text("7 point"),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(tieBreakProvider.notifier)
                          .setTieBreakDuration(10);
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
                    child: const Text("10 point"),
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
      ),
    );
  }
}
