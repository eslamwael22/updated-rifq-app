import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sakina_app/features/duas/data/models/prayers_model.dart';
import 'package:sakina_app/features/duas/data/repo/dua_repo.dart';

part 'duas_state.dart';

class DuasCubit extends Cubit<DuasState> {
  DuasCubit({required this.duaRepo}) : super(DuasInitial());
  final DuaRepo duaRepo;

  Future<void> getPrayers() async {
    emit(DuasLoading());
    final result = await duaRepo.getPrayers();
    result.fold(
      (l) => emit(DuasFailure(errorMessage: l.errorMessage)),
      (r) => emit(DuasSuccess(prayersList: r)),
    );
  }

  Future<void> getSpecialPrayers() async {
    emit(DuasLoading());
    final result = await duaRepo.getFinallyDuas();
    result.fold(
      (l) => emit(DuasFailure(errorMessage: l.errorMessage)),
      (r) => emit(FinalQuranPrayersSuccess(prayersList: r)),
    );
  }
}
