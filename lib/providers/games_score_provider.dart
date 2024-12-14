import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/match_score.dart';

class GamesScoreProvider extends StateNotifier<MatchScore> {
  GamesScoreProvider() : super(MatchScore(set: 1, gameOcean: 0, gameForest: 0));

  void addGame(String team) {
    if (team == "forest") {
      state = state.copyWith(gameForest: state.gameForest + 1);
    }
    if (team == "ocean") {
      state = state.copyWith(gameOcean: state.gameOcean + 1);
    }
  }

  void newSet() {
    state = state.copyWith(set: state.set + 1, gameForest: 0, gameOcean: 0);
  }
}

final gamesScoreProvider =
    StateNotifierProvider<GamesScoreProvider, MatchScore>(
  (ref) => GamesScoreProvider(),
);
