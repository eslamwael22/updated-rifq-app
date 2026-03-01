import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakina_app/features/quran/models/surah_model.dart';
import 'package:sakina_app/features/quran/services/quran_pages_service.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/DotsLoader.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/page_indicator.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/quran_page_content.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/quran_top_overlay_bar.dart';

class SurahDetailsView extends StatefulWidget {
  final Surah surah;
  final int? ayahNumber;

  const SurahDetailsView({
    required this.surah,
    this.ayahNumber,
    super.key,
  });

  @override
  State<SurahDetailsView> createState() => SurahDetailsViewState();
}

class SurahDetailsViewState extends State<SurahDetailsView> {
  static List<QuranPage>? cachedPages;

  late Future<List<QuranPage>> quranPages;
  final PageController pageController = PageController();

  int currentPage = 0;
  int initialPage = 0;
  String currentSurahName = '';
  double fontSize = 24.0;
  bool showOverlay = false;
  bool showSearch = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    currentSurahName = widget.surah.name;
    _loadFontSize();
    loadPages();
  }

  @override
  void dispose() {
    pageController.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  Future<void> loadPages() async {
    if (cachedPages != null) {
      quranPages = Future.value(cachedPages);
    } else {
      quranPages = QuranPagesService.getAllPages();
      cachedPages = await quranPages;
    }

    if (widget.ayahNumber != null) {
      initialPage = await QuranPagesService.getPageNumberForAyah(
        widget.surah.name,
        widget.ayahNumber!,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      final surahKey = 'last_page_${widget.surah.name}';
      final savedPage = prefs.getInt(surahKey);

      final firstPageOfSurah =
          await QuranPagesService.getPageNumberForSurah(widget.surah.name);

      initialPage = savedPage ?? firstPageOfSurah;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && pageController.hasClients) {
        pageController.jumpToPage(initialPage);
        setState(() {
          currentPage = initialPage;
        });
      }
    });

    setState(() {});
  }

  Future<void> saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final surahKey = 'last_page_${widget.surah.name}';
    await prefs.setInt(surahKey, page);
  }

  String getCurrentSurahName(QuranPage pageData) {
    if (pageData.surahs.isNotEmpty) {
      return pageData.surahs.first.surahName;
    }
    return widget.surah.name;
  }

  void _toggleOverlay() {
    _hideTimer?.cancel();

    setState(() {
      showOverlay = !showOverlay;
      if (showOverlay) showSearch = false;
    });

    if (showOverlay) {
      _hideTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showOverlay = false;
            showSearch = false;
          });
        }
      });
    }
  }

  void _changeFontSize(double newSize) {
    setState(() => fontSize = newSize);
    _saveFontSize(newSize);
  }

  Future<void> _saveFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('quran_font_size', size);
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSize = prefs.getDouble('quran_font_size');
    if (savedSize != null) {
      setState(() => fontSize = savedSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          FutureBuilder<List<QuranPage>>(
            future: quranPages,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: DotsLoader());
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('حدث خطأ في تحميل القرآن'),
                );
              }

              if (!snapshot.hasData) {
                return const SizedBox();
              }

              final pages = snapshot.data!;

              return Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                        currentSurahName =
                            getCurrentSurahName(pages[index]);
                      });
                      saveCurrentPage(index);
                    },
                    itemCount: pages.length,
                    itemBuilder: (context, pageIndex) {
                      final pageData = pages[pageIndex];

                      return QuranPageContent(
                        pageData: pageData,
                        pageIndex: pageIndex,
                        allPages: pages,
                        currentSurahName: currentSurahName,
                        fontSize: fontSize,
                        highlightedAyah: widget.ayahNumber,
                        onTap: _toggleOverlay,
                      );
                    },
                  ),
                  PageIndicator(
                    currentPage: currentPage,
                    totalPages: pages.length,
                  ),
                ],
              );
            },
          ),

          QuranTopOverlayBar(
            currentSurahName: currentSurahName,
            fontSize: fontSize,
            showOverlay: showOverlay,
            onFontSizeChanged: _changeFontSize,
            onBackTap: () => Navigator.pop(context),
            onSearchTap: () {},
            currentPageNumber: currentPage + 1,
          ),
        ],
      ),
    );
  }
}