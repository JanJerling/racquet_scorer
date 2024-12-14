class TieBreak {
  final bool isBreaker;
  final int tieDuration;

  TieBreak({required this.isBreaker, required this.tieDuration});

  TieBreak copyWith({
    bool? isBreaker,
    int? tieDuration,
  }) {
    return TieBreak(
      isBreaker: isBreaker ?? this.isBreaker,
      tieDuration: tieDuration ?? this.tieDuration,
    );
  }
}
