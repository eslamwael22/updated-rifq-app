import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/features/quran/services/quran_pages_service.dart';

class QuranText extends StatelessWidget {
  final List<Ayah> verses;
  final double fontSize;
  final int? highlightedAyah;

  const QuranText({
    required this.verses,
    super.key,
    this.fontSize = 31.0,
    this.highlightedAyah,
  });

  String toArabicNumber(int number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String numStr = number.toString();
    for (int i = 0; i < english.length; i++) {
      numStr = numStr.replaceAll(english[i], arabic[i]);
    }
    return numStr;
  }

  String _getFullText() {
    String fullText = '';
    for (int i = 0; i < verses.length; i++) {
      final verse = verses[i];
      if (verse.index == 0) {
        // Basmala - center it
        fullText += '    ${verse.text}    \n\n';
      } else {
        fullText += '${verse.text} ${toArabicNumber(verse.index)} ';
      }
    }
    return fullText.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Basmala if present
        if (verses.isNotEmpty && verses.first.index == 0)
          Center(
            child: Text(
              verses.first.text,
              style: TextStyle(
                fontSize: fontSize + 4,
                fontWeight: FontWeight.bold,
                fontFamily: 'uthmanic',
                color: Theme.of(context).colorScheme.primary,
                height: 1.5,
              ),
            ),
          ),

        // Regular verses with selectable text
        if (verses.isNotEmpty && verses.first.index == 0)
          SizedBox(height: 10.h),

        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SelectableText.rich(
            TextSpan(
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'uthmanic',
                height: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              children: verses
                  .where((verse) => verse.index != 0)
                  .map<InlineSpan>((verse) {
                    final isHighlighted = verse.index == highlightedAyah;
                    return TextSpan(
                      children: [
                        TextSpan(
                          text: '${verse.text} ',
                          style: isHighlighted
                              ? TextStyle(
                                  fontSize: fontSize,
                                  fontFamily: 'uthmanic',
                                  height: 2,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                )
                              : TextStyle(
                                  fontSize: fontSize,
                                  fontFamily: 'uthmanic',
                                  height: 2,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                        ),
                        TextSpan(
                          text: '${toArabicNumber(verse.index)} ',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: isHighlighted
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            backgroundColor: isHighlighted
                                ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                                : null,
                          ),
                        ),
                      ],
                    );
                  })
                  .toList(),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
