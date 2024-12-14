import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:racquet_scorer/classes/tie_break.dart';

class TieBreakProvider extends StateNotifier<TieBreak> {
  TieBreakProvider() : super(TieBreak(isBreaker: false, tieDuration: 7));

  void toggleTieBreak() {
    state = state.copyWith(isBreaker: !state.isBreaker);
  }

  void setTieBreakDuration(int duration) {
    state = state.copyWith(tieDuration: duration);
  }
}

final tieBreakProvider = StateNotifierProvider<TieBreakProvider, TieBreak>(
  (ref) => TieBreakProvider(),
);
