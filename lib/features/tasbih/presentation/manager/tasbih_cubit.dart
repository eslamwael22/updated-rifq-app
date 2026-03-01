import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'tasbih_state.dart';

class TasbihCubit extends HydratedCubit<TasbihState> {
  TasbihCubit() : super(TasbihState.initial());

  void increment() {
    if (state.count + 1 >= state.target) {
      emit(
        state.copyWith(
          count: 0,
          round: state.round + 1,
          fullCount: state.fullCount + 1,
        ),
      );
    } else {
      emit(
        state.copyWith(
          count: state.count + 1,
          fullCount: state.fullCount + 1,
        ),
      );
    }
  }

  void reset() {
    emit(state.copyWith(count: 0));
  }

  void resetAll() {
    emit(TasbihState.initial());
  }

  void changeZakar(String zakar) {
    emit(
      state.copyWith(
        zakar: zakar,
        count: 0,
      ),
    );
  }

  void changeTarget(int target) {
    emit(
      state.copyWith(
        target: target,
        count: 0,
      ),
    );
  }

  @override
  TasbihState? fromJson(Map<String, dynamic> json) {
    try {
      return TasbihState(
        count: json['count'] as int,
        target: json['target'] as int,
        zakar: json['zakar'] as String,
        fullCount: json['fullCount'] as int,
        round: json['round'] as int,
      );
    } catch (_) {
      return TasbihState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(TasbihState state) {
    return {
      'count': state.count,
      'target': state.target,
      'zakar': state.zakar,
      'fullCount': state.fullCount,
      'round': state.round,
    };
  }
}
