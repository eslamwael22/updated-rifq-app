// lib/features/quran/presentation/views/quran_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/features/quran/data/surah_data.dart';
import 'package:sakina_app/features/quran/models/surah_model.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/quran_header.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/filter_buttons.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/stats_cards.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/surahs_list.dart';

class QuranView extends StatefulWidget {
  const QuranView({super.key});

  @override
  State<QuranView> createState() => QuranViewState();
}

class QuranViewState extends State<QuranView> {
  String selectedType = 'الكل';
  String searchQuery = '';
  List<Surah> filteredSurahs = surahsList;

  @override
  void initState() {
    super.initState();
    filteredSurahs = surahsList;
  }

  void filterSurahs(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredSurahs = getSurahsByType();
      } else {
        filteredSurahs = getSurahsByType()
            .where((surah) => 
                surah.name.contains(query) ||
                surah.name.toLowerCase().contains(query.toLowerCase())
            )
            .toList();
      }
    });
  }

  List<Surah> getSurahsByType() {
    if (selectedType == 'مكية') {
      return surahsList.where((surah) => surah.type == 'مكية').toList();
    } else if (selectedType == 'مدنية') {
      return surahsList.where((surah) => surah.type == 'مدنية').toList();
    } else {
      return surahsList;
    }
  }

  void updateSelectedType(String type) {
    setState(() {
      selectedType = type;
      searchQuery = '';
      filteredSurahs = getSurahsByType();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawerEdgeDragWidth: MediaQuery.of(context).viewInsets.bottom,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          QuranHeader(
            surahCount: filteredSurahs.length,
            onSearch: filterSurahs,
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              physics: const ClampingScrollPhysics(),
              children: [
                FilterButtons(
                  selectedType: selectedType,
                  onTypeSelected: updateSelectedType,
                ),
                SizedBox(height: 20.h),
                const StatsCards(),
                SizedBox(height: 20.h),
                SurahsList(surahs: filteredSurahs),
              ],
            ),
          ),
        ],
      ),
    );
  }
}