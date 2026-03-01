import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sakina_app/core/error/location_error.dart';
import 'package:sakina_app/l10n/app_localizations.dart';

class LocationService {
  LocationService._internal();
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;

  final StreamController<Position> _locationController =
      StreamController<Position>.broadcast();

  StreamSubscription<Position>? _subscription;

  Stream<Position> get locationStream => _locationController.stream;

  Future<Either<LocationFailure, bool>> _checkPermissions({
    required BuildContext context,
  }) async {
    final local = AppLocalizations.of(context)!;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Left(
        LocationFailure(errorMessage: local.locationServicesDisabled),
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Left(
          LocationFailure(errorMessage: local.locationPermissionsDenied),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Left(
        LocationFailure(
          errorMessage: local.locationPermissionsDeniedForever,
        ),
      );
    }

    return const Right(true);
  }

  Future<Either<LocationFailure, bool>> startListening({
    required BuildContext context,
    int distanceFilter = 10,
  }) async {
    final permissionResult = await _checkPermissions(context: context);

    if (permissionResult.isLeft()) {
      return permissionResult;
    }

    await _subscription?.cancel();

    _subscription =
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: distanceFilter,
          ),
        ).listen(
          (position) {
            _locationController.add(position);
            log('Location update: ${position.latitude}, ${position.longitude}');
          },
          onError: (error) {
            _locationController.addError(error);
          },
        );

    return const Right(true);
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  Future<Either<LocationFailure, Position>> getCurrentPosition({
    required BuildContext context,
  }) async {
    final permissionResult = await _checkPermissions(context: context);

    if (permissionResult.isLeft()) {
      return Left(
        LocationFailure(
          errorMessage: AppLocalizations.of(context)!.locationPermissionsDenied,
        ),
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return Right(position);
    } catch (e) {
      return Left(
        LocationFailure(errorMessage: e.toString()),
      );
    }
  }

  void dispose() {
    _subscription?.cancel();
    _locationController.close();
  }
}
