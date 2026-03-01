import 'ayah_model.dart';

class SurahDetails {
  final int number;
  final String name;
  final String englishName;
  final int numberOfAyahs;
  final String revelationType;
  final List<Ayah> ayahs;

  SurahDetails({
    required this.number,
    required this.name,
    required this.englishName,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.ayahs,
  });
}
