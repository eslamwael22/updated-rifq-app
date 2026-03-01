import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:sakina_app/core/constants/keys.dart';
import 'package:sakina_app/features/hadith/data/models/hadith_model/hadith_model.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit() : super(HadithInitial());

  List<HadithModel> hadithCached = [];
  Future<void> loadHadith() async {
    if (hadithCached.isNotEmpty) {
      emit(HadithSuccess(hadithCached));
    }
    try {
      emit(HadithLoading());
      final hadith = await rootBundle.loadString(AppKeys.hadithPath);
      final List<HadithModel> hadithList = [];
      for (var item in jsonDecode(hadith)) {
        hadithList.add(HadithModel.fromJson(item));
      }
      hadithCached = hadithList;
      emit(HadithSuccess(hadithList));
    } catch (e) {
      emit(HadithFailure(e.toString()));
    }
  }
}
