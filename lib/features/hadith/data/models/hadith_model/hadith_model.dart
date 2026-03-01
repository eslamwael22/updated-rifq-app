import 'package:equatable/equatable.dart';

class HadithModel extends Equatable {
  final int? hadithId;
  final String? title;
  final String? hadithText;
  final String? narrator;
  final String? explanation;
  final String? source;

  const HadithModel({
    this.hadithId,
    this.title,
    this.hadithText,
    this.narrator,
    this.explanation,
    this.source,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    hadithId: json['hadith_id'] as int?,
    title: json['title'] as String?,
    hadithText: json['hadith_text'] as String?,
    narrator: json['narrator'] as String?,
    explanation: json['explanation'] as String?,
    source: json['source'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'hadith_id': hadithId,
    'title': title,
    'hadith_text': hadithText,
    'narrator': narrator,
    'explanation': explanation,
    'source': source,
  };

  @override
  List<Object?> get props {
    return [
      hadithId,
      title,
      hadithText,
      narrator,
      explanation,
      source,
    ];
  }
}
