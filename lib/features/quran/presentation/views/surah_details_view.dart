import 'package:flutter/material.dart';
import 'package:sakina_app/core/helper/shared_prefs.dart';
import 'package:sakina_app/core/utils/custom_snack_bar.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/DotsLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakina_app/features/quran/models/surah_model.dart';
import 'package:sakina_app/features/quran/services/quran_pages_service.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/page_indicator.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/quran_page_content.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/quran_top_overlay_bar.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurahDetailsView extends StatefulWidget {
  final Surah surah;
  final int? ayahNumber;

  const SurahDetailsView({required this.surah, this.ayahNumber, super.key});

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
  String searchQuery = '';
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

    // If ayah number is provided, navigate to that specific ayah
    if (widget.ayahNumber != null) {
      final ayahPage = await QuranPagesService.getPageNumberForAyah(
        widget.surah.name,
        widget.ayahNumber!,
      );
      initialPage = ayahPage;
    } else {
      // Load saved page for this specific surah
      final prefs = await SharedPreferences.getInstance();
      final surahKey = 'last_page_${widget.surah.name}';
      final savedPage = prefs.getInt(surahKey);

      // Get the first page of this surah
      final firstPageOfSurah = await QuranPagesService.getPageNumberForSurah(
        widget.surah.name,
      );

      // Check if saved page is still within this surah
      bool isStillInThisSurah = false;
      if (savedPage != null) {
        final savedPageData = (await quranPages)[savedPage];
        for (var surah in savedPageData.surahs) {
          if (surah.surahName == widget.surah.name) {
            isStillInThisSurah = true;
            break;
          }
        }
      }

      // Use saved page if it's still in this surah, otherwise use first page
      initialPage = (isStillInThisSurah && savedPage != null)
          ? savedPage
          : firstPageOfSurah;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients && mounted) {
        pageController.jumpToPage(initialPage);
        setState(() {
          currentPage = initialPage;
        });
      }
    });

    setState(() {});
  }

  // Save current page for this specific surah
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
    setState(() {
      showOverlay = !showOverlay;
      if (showOverlay) {
        showSearch = false;
      }
    });

    if (showOverlay) {
      _hideTimer?.cancel();
      _hideTimer = Timer(const Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            showOverlay = false;
            showSearch = false;
          });
        }
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      showSearch = !showSearch;
      if (showSearch) {
        showOverlay = true;
      }
    });
  }

  void _changeFontSize(double newSize) {
    setState(() {
      fontSize = newSize;
    });

    // Save font size to SharedPreferences
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
      setState(() {
        fontSize = savedSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: _toggleOverlay,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 60.h),

                Expanded(
                  child: FutureBuilder<List<QuranPage>>(
                    future: quranPages,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: DotsLoader(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('حدث خطأ في تحميل القرآن'),
                        );
                      } else if (snapshot.hasData) {
                        final pages = snapshot.data!;
                        return Stack(
                          children: [
                            PageView.builder(
                              controller: pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  currentPage = index;
                                  currentSurahName = getCurrentSurahName(
                                    pages[index],
                                  );
                                });
                                // Save current page to SharedPreferences
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
                                );
                              },
                            ),

                            PageIndicator(
                              currentPage: currentPage,
                              totalPages: pages.length,
                            ),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),

            // Top Overlay Bar
            QuranTopOverlayBar(
              currentSurahName: currentSurahName,
              fontSize: fontSize,
              showOverlay: showOverlay && !showSearch,
              onFontSizeChanged: _changeFontSize,
              onBackTap: () => Navigator.pop(context),
              onSearchTap: () =>
                  Navigator.pop(context), // Go back to home instead of search
              currentPageNumber: currentPage + 1, // Pages start from 1
            ),

            // Search Overlay
          ],
        ),
      ),
    );
  }
}
