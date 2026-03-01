import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:sakina_app/core/constants/keys.dart';
import 'package:sakina_app/features/riquat_shareia/data/models/riquat_quran_model/riquat_quran_model.dart';

part 'riquat_quran_state.dart';

class RiquatQuranCubit extends Cubit<RiquatQuranState> {
  RiquatQuranCubit() : super(RiquatQuranInitial());
  List<RiquatQuranModel> cachedList = [];
  Future<void> loadRiquatQuran() async {
    if (cachedList.isNotEmpty) {
      emit(RiquatQuranSuccess(riquatList: cachedList));
      return;
    }
    try {
      emit(RiquatQuranLoading());
      final String json = await rootBundle.loadString(
        AppKeys.riquatQuran,
      );
      final List<RiquatQuranModel> riquatList = [];
      for (var item in jsonDecode(json)) {
        riquatList.add(RiquatQuranModel.fromJson(item));
      }
      log(riquatList.toString());
      cachedList = riquatList;
      emit(RiquatQuranSuccess(riquatList: riquatList));
    } catch (e) {
      emit(RiquatQuranFailure(errorMessage: 'oops something went wrong + $e'));
    }
  }
}
