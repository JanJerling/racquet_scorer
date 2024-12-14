import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitScreen extends StatelessWidget {
  const ExitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 180,
              child: Center(
                child: Text(
                    "Are you sure you want to exit the app?\nAll score data will be lost."),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      minimumSize: WidgetStatePropertyAll(Size(100, 50)),
                    ),
                    child: const Text("Return"),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: () {
                      SystemNavigator.pop(); // Close the app
                    },
                    style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      minimumSize: WidgetStatePropertyAll(Size(100, 50)),
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                    ),
                    child: const Text("Exit"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
