import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/match_score.dart';

class SetListProvider extends StateNotifier<List<MatchScore>> {
  SetListProvider() : super([]);

  void addMatch(MatchScore score) {
    state = [...state, score];
  }
}

final setListProvider =
    StateNotifierProvider<SetListProvider, List<MatchScore>>(
  (ref) => SetListProvider(),
);
