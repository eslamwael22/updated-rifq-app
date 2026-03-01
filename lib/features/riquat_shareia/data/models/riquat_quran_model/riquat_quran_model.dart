import 'package:equatable/equatable.dart';

class RiquatQuranModel extends Equatable {
  final String? surah;
  final int? startAyah;
  final int? endAyah;
  final String? text;

  const RiquatQuranModel({
    this.surah,
    this.startAyah,
    this.endAyah,
    this.text,
  });

  factory RiquatQuranModel.fromJson(Map<String, dynamic> json) {
    return RiquatQuranModel(
      surah: json['surah'] as String?,
      startAyah: json['start_ayah'] as int?,
      endAyah: json['end_ayah'] as int?,
      text: json['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'surah': surah,
    'start_ayah': startAyah,
    'end_ayah': endAyah,
    'text': text,
  };

  @override
  List<Object?> get props => [surah, startAyah, endAyah, text];
}
