import 'package:flutter/material.dart';
import 'package:sakina_app/features/quran/services/quran_pages_service.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/surah_title.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/quran_text.dart';

class QuranPageContent extends StatelessWidget {
  final QuranPage pageData;
  final int pageIndex;
  final List<QuranPage> allPages;
  final String currentSurahName;
  final double fontSize;
  final int? highlightedAyah;

  const QuranPageContent({
    required this.pageData,
    required this.pageIndex,
    required this.allPages,
    required this.currentSurahName,
    required this.fontSize,
    this.highlightedAyah,
    super.key,
  });

  bool shouldShowSurahTitle(String surahName) {
    if (pageIndex == 0) return true;

    final previousPage = allPages[pageIndex - 1];

    // Check if this surah was already shown in previous page
    for (var surah in previousPage.surahs) {
      if (surah.surahName == surahName) {
        return false;
      }
    }
    
    // Always show title for first surah in page or if it's a new surah
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 2,
                bottom: 70,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: pageData.surahs.asMap().entries.map((entry) {
                  final surahInPage = entry.value;
                  final String surahName = surahInPage.surahName;
                  final List<Ayah> verses = surahInPage.ayahs;

                  final bool showTitle = shouldShowSurahTitle(surahName);

                  return Column(
                    children: [
                      SurahTitle(
                        surahName: surahName,
                        showTitle: showTitle,
                      ),
                      SizedBox(height: 2),
                      QuranText(
                        verses: verses,
                        fontSize: fontSize,
                        highlightedAyah: highlightedAyah,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
