part of 'duas_cubit.dart';

sealed class DuasState extends Equatable {
  const DuasState();

  @override
  List<Object> get props => [];
}

final class DuasInitial extends DuasState {}

final class DuasLoading extends DuasState {}

final class DuasSuccess extends DuasState {
  final List<PrayersModel> prayersList;

  const DuasSuccess({required this.prayersList});

  @override
  List<Object> get props => [prayersList];
}

final class DuasFailure extends DuasState {
  final String errorMessage;

  const DuasFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class FinalQuranPrayersSuccess extends DuasState {
  final List<PrayersModel> prayersList;

  const FinalQuranPrayersSuccess({required this.prayersList});
}
