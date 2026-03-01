part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationStateInitial extends LocationState {}

final class LocationStateSuccess extends LocationState {}

final class LocationStateFailure extends LocationState {
  final String error;
  const LocationStateFailure({required this.error});
}

final class LocationStateLoading extends LocationState {}
