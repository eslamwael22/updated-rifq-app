import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  QiblaCubit() : super(const QiblaState());

  StreamSubscription<CompassEvent>? _compassSubscription;

  Future<void> getCurrentLocation() async {
    if (isClosed) return;
    emit(state.copyWith(status: QiblaStatus.loading));

    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isClosed) return;
      if (!serviceEnabled) {
        emit(
          state.copyWith(
            status: QiblaStatus.error,
            errorMessage: 'خدمات الموقع غير مفعلة',
          ),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (isClosed) return;
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (isClosed) return;
        if (permission == LocationPermission.denied) {
          emit(
            state.copyWith(
              status: QiblaStatus.error,
              errorMessage: 'تم رفض إذن الموقع',
            ),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          state.copyWith(
            status: QiblaStatus.error,
            errorMessage: 'تم رفض إذن الموقع بشكل دائم',
          ),
        );
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (isClosed) return;

      String address = 'موقع غير معروف';
      try {
        final List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          address = '${place.locality ?? ''}, ${place.country ?? ''}';
        }
      } catch (_) {
        // في حالة فشل جلب العنوان نكمل بالموقع الافتراضي
      }

      if (isClosed) return;

      final coordinates = Coordinates(position.latitude, position.longitude);
      final qiblaDirection = Qibla.qibla(coordinates);

      emit(
        state.copyWith(
          status: QiblaStatus.success,
          latitude: position.latitude,
          longitude: position.longitude,
          qiblaDirection: qiblaDirection,
          address: address,
        ),
      );

      _startCompassTracking();
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: QiblaStatus.error,
          errorMessage: 'حدث خطأ: ${e.toString()}',
        ),
      );
    }
  }

  void _startCompassTracking() {
    _compassSubscription?.cancel();

    _compassSubscription = FlutterCompass.events?.listen((CompassEvent event) {
      if (isClosed) return;
      if (event.heading == null) return;

      if (event.accuracy != null && event.accuracy! < 2) {
        emit(
          state.copyWith(
            status: QiblaStatus.error,
            errorMessage: 'البوصلة تحتاج للمعايرة. حرك الهاتف على شكل رقم 8',
          ),
        );
      } else {
        updateDeviceDirection(event.heading!);
      }
    });
  }

  void updateDeviceDirection(double direction) {
    if (isClosed) return;

    debugPrint('=== Compass Debug Info ===');
    debugPrint('Device Direction: ${direction.toStringAsFixed(1)}°');
    debugPrint('Qibla Direction: ${state.qiblaDirection?.toStringAsFixed(1)}°');

    if (state.qiblaDirection != null) {
      double difference = direction - state.qiblaDirection!;
      while (difference > 180) {
        difference -= 360;
      }
      while (difference < -180) {
        difference += 360;
      }
      debugPrint('Difference: ${difference.toStringAsFixed(1)}°');
    }
    debugPrint('========================');

    emit(state.copyWith(deviceDirection: direction));
  }

  @override
  Future<void> close() {
    _compassSubscription?.cancel();
    return super.close();
  }
}
