import 'package:flutter/material.dart';

class SettingModel {
  final String title;
  final String subTitle;
  final bool isShow;
  final IconData icon;
  SettingModel({
    required this.title,
    required this.subTitle,
    required this.isShow,
    required this.icon,
  });
  static List<SettingModel> firstSettingList = [
    SettingModel(
      title: 'الوضع الليلي',
      subTitle: 'تبديل بين الوضع الفاتح والداكن',
      isShow: true,
      icon: Icons.dark_mode_outlined,
      
    ),
    SettingModel(
      title: 'الأشعارات',
      subTitle: 'تفعيل الأشعارات',
      isShow: false,
      icon: Icons.notifications_none_outlined,
    ),
  ];
  static List<SettingModel> secondSettingList = [
    SettingModel(
      isShow: false,
      title: 'نوع الرسم',
      subTitle: 'تغيير نوع الرسم',
      icon: Icons.color_lens_outlined,
    ),
    SettingModel(
      isShow: false,
      title: 'اعدادات المصحف',
      subTitle: 'تغيير اعدادات المصحف',
      icon: Icons.language,
    ),
  ];

  static final List<SettingModel> thirdSettingList = [
    SettingModel(
      isShow: false,
      title: 'سياسة الخصوصية',
      subTitle: 'احترام خصوصيتك هو أولويتنا',
      icon: Icons.privacy_tip_outlined,
    ),
    SettingModel(
      title: 'الشروط والأحكام',
      subTitle: 'الاستخدام الصحيح للتطبيق',
      icon: Icons.gavel_outlined,
      isShow: false,
    ),
    SettingModel(
      isShow: false,
      title: 'حول التطبيق',
      subTitle: 'معلومات عن تطبيق رِفْق',
      icon: Icons.info_outline,
    ),
  ];
}
