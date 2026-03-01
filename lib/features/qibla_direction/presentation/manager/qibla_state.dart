part of 'qibla_cubit.dart';

enum QiblaStatus {
  initial,
  loading,
  success,
  error,
}

class QiblaState extends Equatable {
  final QiblaStatus status;
  final double? latitude;
  final double? longitude;
  final double? qiblaDirection;
  final double? deviceDirection;
  final String? address;
  final String? errorMessage;

  const QiblaState({
    this.status = QiblaStatus.initial,
    this.latitude,
    this.longitude,
    this.qiblaDirection,
    this.deviceDirection,
    this.address,
    this.errorMessage,
  });

  QiblaState copyWith({
    QiblaStatus? status,
    double? latitude,
    double? longitude,
    double? qiblaDirection,
    double? deviceDirection,
    String? address,
    String? errorMessage,
  }) {
    return QiblaState(
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      qiblaDirection: qiblaDirection ?? this.qiblaDirection,
      deviceDirection: deviceDirection ?? this.deviceDirection,
      address: address ?? this.address,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        latitude,
        longitude,
        qiblaDirection,
        deviceDirection,
        address,
        errorMessage,
      ];
}
