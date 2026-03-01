import 'package:flutter/material.dart';

class OnBoardingModel {
  final IconData icon;
  final String title;
  final String desc;
  final List<Color> colors;
  OnBoardingModel({
    required this.colors,
    required this.desc,
    required this.icon,
    required this.title,
  });
  static final List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      icon: Icons.menu_book_rounded,
      title: 'الأحاديث والشرح',
      desc: 'اقرأ الأحاديث وفهمها مع شرح مبسط وواضح.',
      colors: [Color(0xFF0D7E5E), Color(0xFF0A3F2A)],
    ),
    OnBoardingModel(
      icon: Icons.auto_stories,
      title: 'التسبيح والذكر',
      desc: 'استمع للأذكار اليومية وسبّح مع التطبيق بسهولة.',
      colors: [Color(0xFF117C6C), Color(0xFF053F34)],
    ),
    OnBoardingModel(
      icon: Icons.book,
      title: 'القرآن الكريم',
      desc: 'استمع للقرآن الكريم بسهولة واستخدمه أوفلاين.',
      colors: [Color(0xFF0F8F6C), Color(0xFF045D3C)],
    ),

    OnBoardingModel(
      icon: Icons.mosque_outlined,
      title: 'معرفة القبلة',
      desc: 'تعرّف على اتجاه القبلة بدقة من أي مكان.',
      colors: [Color(0xFF0B5E4D), Color(0xFF02372B)],
    ),
  ];
}
