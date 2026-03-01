import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:sakina_app/core/service/get_location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.locationService) : super(LocationStateInitial());
  final LocationService locationService;

  Future<void> startLocationService({required BuildContext context}) async {
    emit(LocationStateLoading());
    final started = await locationService.startListening(context: context);
    started.fold(
      (failure) => emit(LocationStateFailure(error: failure.errorMessage)),
      (success) {
        emit(LocationStateSuccess());
      },
    );
  }
}
