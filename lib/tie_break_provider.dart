import 'package:flutter_riverpod/flutter_riverpod.dart';

class TieBreakProvider extends StateNotifier<bool> {
  TieBreakProvider() : super(false);

  void toggleTieBreak() {
    state = !state;
  }
}

final tieBreakProvider = StateNotifierProvider<TieBreakProvider, bool>(
  (ref) => TieBreakProvider(),
);
