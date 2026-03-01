// lib/features/quran/services/quran_xml_service.dart
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;
import '../models/surah_details_model.dart';
import '../models/ayah_model.dart';

class QuranXmlService {
  static xml.XmlDocument? _cachedDocument;

  // تحميل وتخزين الـ XML مرة واحدة
  static Future<xml.XmlDocument> loadQuranXml() async {
    if (_cachedDocument != null) return _cachedDocument!;

    final String xmlString = await rootBundle.loadString(
      'assets/quran/quran-uthmani-min.xml',
    );
    _cachedDocument = xml.XmlDocument.parse(xmlString);
    return _cachedDocument!;
  }

  // جلب تفاصيل سورة معينة
  static Future<SurahDetails> getSurahDetails(int surahNumber) async {
    try {
      final document = await loadQuranXml();

      // البحث عن السورة في الـ XML
      final surahs = document.findAllElements('sura');

      xml.XmlElement? targetSurah;
      for (var sura in surahs) {
        final index = int.parse(sura.getAttribute('index') ?? '0');
        if (index == surahNumber) {
          targetSurah = sura;
          break;
        }
      }

      if (targetSurah == null) {
        throw Exception('السورة غير موجودة');
      }

      // معلومات السورة
      final name = targetSurah.getAttribute('name') ?? '';
      final englishName = targetSurah.getAttribute('tname') ?? '';
      final type = targetSurah.getAttribute('type') ?? '';

      // جمع الآيات
      final List<Ayah> ayahs = [];
      final ayahElements = targetSurah.findElements('aya');

      for (var ayahElement in ayahElements) {
        final ayahIndex = int.parse(ayahElement.getAttribute('index') ?? '0');
        final ayahText = ayahElement.getAttribute('text') ?? '';

        ayahs.add(
          Ayah(
            number: ayahIndex,
            text: ayahText,
            numberInSurah: ayahIndex,
          ),
        );
      }

      return SurahDetails(
        number: surahNumber,
        name: name,
        englishName: englishName,
        numberOfAyahs: ayahs.length,
        revelationType: type == 'Meccan' ? 'مكية' : 'مدنية',
        ayahs: ayahs,
      );
    } catch (e) {
      throw Exception('خطأ في تحميل السورة: $e');
    }
  }

  // جلب كل أسماء السور (للقائمة الرئيسية)
  static Future<List<Map<String, dynamic>>> getAllSurahsInfo() async {
    try {
      final document = await loadQuranXml();
      final surahs = document.findAllElements('sura');

      final List<Map<String, dynamic>> surahsList = [];

      for (var sura in surahs) {
        surahsList.add({
          'number': int.parse(sura.getAttribute('index') ?? '0'),
          'name': sura.getAttribute('name') ?? '',
          'englishName': sura.getAttribute('tname') ?? '',
          'type': sura.getAttribute('type') ?? '',
          'verses': sura.findElements('aya').length,
        });
      }

      return surahsList;
    } catch (e) {
      throw Exception('خطأ في تحميل البيانات: $e');
    }
  }

  // البحث في القرآن
  static Future<List<Map<String, dynamic>>> searchInQuran(String query) async {
    try {
      final document = await loadQuranXml();
      final surahs = document.findAllElements('sura');

      final List<Map<String, dynamic>> results = [];

      for (var sura in surahs) {
        final surahNumber = int.parse(sura.getAttribute('index') ?? '0');
        final surahName = sura.getAttribute('name') ?? '';
        final ayahs = sura.findElements('aya');

        for (var aya in ayahs) {
          final ayaText = aya.getAttribute('text') ?? '';
          final ayaIndex = int.parse(aya.getAttribute('index') ?? '0');

          if (ayaText.contains(query)) {
            results.add({
              'surahNumber': surahNumber,
              'surahName': surahName,
              'ayahNumber': ayaIndex,
              'text': ayaText,
            });
          }
        }
      }

      return results;
    } catch (e) {
      throw Exception('خطأ في البحث: $e');
    }
  }
}
