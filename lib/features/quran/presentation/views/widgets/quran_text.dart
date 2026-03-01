import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/features/quran/services/quran_pages_service.dart';

class QuranText extends StatelessWidget {
  final List<Ayah> verses;
  final double fontSize;
  final int? highlightedAyah;
  final VoidCallback? onTap;

  const QuranText({
    required this.verses,
    super.key,
    this.fontSize = 31.0,
    this.highlightedAyah,
    this.onTap,
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

  String normalizeVerse(String text) {
    return text.replaceAll('\u06DF', '\u0652');
  }

  String _getFullText() {
    return verses
        .where((v) => v.index != 0)
        .map((v) => '${v.text} ${toArabicNumber(v.index)}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Basmala
        if (verses.isNotEmpty && verses.first.index == 0) ...[
          Center(
            child: Text(
              verses.first.text,
              style: TextStyle(
                fontSize: fontSize + 4,
                fontWeight: FontWeight.bold,
                fontFamily: 'uthmanic',
                color: theme.colorScheme.primary,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],

        /// Verses
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          onLongPress: () async {
            await Clipboard.setData(
              ClipboardData(text: _getFullText()),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم نسخ الآيات'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'uthmanic',
                height: 2,
                color: theme.colorScheme.onSurface,
              ),
              children: verses
                  .where((verse) => verse.index != 0)
                  .map<InlineSpan>((verse) {
                final isHighlighted = verse.index == highlightedAyah;

                final highlightColor =
                    theme.colorScheme.primary.withOpacity(0.25);

                return TextSpan(
                  children: [
                    TextSpan(
                      text: '${normalizeVerse(verse.text)} ',
                      style: isHighlighted
                          ? TextStyle(
                              backgroundColor: highlightColor,
                            )
                          : null,
                    ),
                    TextSpan(
                      text: '${toArabicNumber(verse.index)} ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isHighlighted
                            ? theme.colorScheme.primary
                            : theme.colorScheme.primary,
                        backgroundColor:
                            isHighlighted ? highlightColor : null,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}