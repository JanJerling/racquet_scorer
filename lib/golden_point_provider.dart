import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoldenPointProvider extends StateNotifier<bool> {
  GoldenPointProvider() : super(false);

  void toggleGoldenPoint() {
    state = !state;
  }
}

final goldenPointProvider = StateNotifierProvider<GoldenPointProvider, bool>(
  (ref) => GoldenPointProvider(),
);
