import 'package:equatable/equatable.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_tasbih_list.dart';

class TasbihState extends Equatable {
  final int count;
  final int target;
  final String zakar;
  final int fullCount;
  final int round;

  const TasbihState({
    required this.count,
    required this.target,
    required this.zakar,
    required this.fullCount,
    required this.round,
  });

  factory TasbihState.initial() {
    return TasbihState(
      count: 0,
      target: 33,
      zakar: tasbihList[0],
      fullCount: 0,
      round: 0,
    );
  }

  bool get isCompleted => count >= target;

  TasbihState copyWith({
    int? count,
    int? target,
    String? zakar,
    int? fullCount,
    int? round,
  }) {
    return TasbihState(
      count: count ?? this.count,
      target: target ?? this.target,
      zakar: zakar ?? this.zakar,
      fullCount: fullCount ?? this.fullCount,
      round: round ?? this.round,
    );
  }

  @override
  List<Object?> get props => [
    count,
    target,
    zakar,
    fullCount,
    round,
  ];
}
