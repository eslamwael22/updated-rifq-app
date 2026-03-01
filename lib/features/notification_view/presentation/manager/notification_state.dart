class NotificationState {
  final bool salawat;
  final bool randomAzkar;
  final bool morningEvening;
  final bool dailyWerd;

  const NotificationState({
    required this.salawat,
    required this.randomAzkar,
    required this.morningEvening,
    required this.dailyWerd,
  });

  factory NotificationState.inital() {
    return const NotificationState(
      salawat: true,
      randomAzkar: true,
      morningEvening: true,
      dailyWerd: true,
    );
  }
  NotificationState copyWith({
    bool? salawat,
    bool? randomAzkar,
    bool? morningEvening,
    bool? dailyWerd,
  }) {
    return NotificationState(
      salawat: salawat ?? this.salawat,
      randomAzkar: randomAzkar ?? this.randomAzkar,
      morningEvening: morningEvening ?? this.morningEvening,
      dailyWerd: dailyWerd ?? this.dailyWerd,
    );
  }
}
