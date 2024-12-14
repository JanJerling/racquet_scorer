import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/match_score.dart';

class SetListProvider extends StateNotifier<List<MatchScore>> {
  SetListProvider() : super([MatchScore(set: 1, gameOcean: 0, gameForest: 0)]);

  void addMatch(MatchScore score) {
    state = [...state, score];
  }

  void updateMatch(MatchScore score) {
    List<MatchScore> newList = state;
    newList[score.set - 1] = score;
    state = newList;
  }
}

final setListProvider =
    StateNotifierProvider<SetListProvider, List<MatchScore>>(
  (ref) => SetListProvider(),
);
