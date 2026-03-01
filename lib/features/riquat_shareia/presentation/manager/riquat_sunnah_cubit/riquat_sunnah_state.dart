part of 'riquat_sunnah_cubit.dart';

sealed class RiquatSunnahState extends Equatable {
  const RiquatSunnahState();

  @override
  List<Object> get props => [];
}

final class RiquatSunnahInitial extends RiquatSunnahState {}

final class RiquatSunnahLoading extends RiquatSunnahState {}

final class RiquatSunnahSuccess extends RiquatSunnahState {
  final List<RiquatSunnahModel> riquatList;
  const RiquatSunnahSuccess(this.riquatList);

  @override
  List<Object> get props => [riquatList];
}

final class RiquatSunnahFailure extends RiquatSunnahState {
  final String errorMessage;
  const RiquatSunnahFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
