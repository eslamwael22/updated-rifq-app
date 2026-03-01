part of 'riquat_quran_cubit.dart';

sealed class RiquatQuranState extends Equatable {
  const RiquatQuranState();

  @override
  List<Object> get props => [];
}

final class RiquatQuranInitial extends RiquatQuranState {}

final class RiquatQuranSuccess extends RiquatQuranState {
  final List<RiquatQuranModel> riquatList;

  const RiquatQuranSuccess({required this.riquatList});

  @override
  List<Object> get props => [riquatList];
}

final class RiquatQuranLoading extends RiquatQuranState {}

final class RiquatQuranFailure extends RiquatQuranState {
  final String errorMessage;

  const RiquatQuranFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
