class MatchScore {
  final int set;
  final int gameOcean;
  final int gameForest;

  MatchScore(
      {required this.set, required this.gameOcean, required this.gameForest});

  MatchScore copyWith({
    int? set,
    int? gameOcean,
    int? gameForest,
  }) {
    return MatchScore(
      set: set ?? this.set,
      gameOcean: gameOcean ?? this.gameOcean,
      gameForest: gameForest ?? this.gameForest,
    );
  }
}
