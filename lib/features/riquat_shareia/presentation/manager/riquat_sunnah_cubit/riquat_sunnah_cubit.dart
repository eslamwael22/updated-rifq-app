import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:sakina_app/core/constants/keys.dart';
import 'package:sakina_app/features/riquat_shareia/data/models/riquat_model.dart';

part 'riquat_sunnah_state.dart';

class RiquatSunnahCubit extends Cubit<RiquatSunnahState> {
  RiquatSunnahCubit() : super(RiquatSunnahInitial());
  List<RiquatSunnahModel> cachedList = [];
  Future<void> loadRiquatSunnah() async {
    if (cachedList.isNotEmpty) {
      emit(RiquatSunnahSuccess(cachedList));
      return;
    }
    try {
      emit(RiquatSunnahLoading());
      final String json = await rootBundle.loadString(
        AppKeys.riquatSunnah,
      );
      final List<RiquatSunnahModel> riquatList = [];
      for (var item in jsonDecode(json)) {
        riquatList.add(RiquatSunnahModel.fromJson(item));
      }
      cachedList = riquatList;
      emit(RiquatSunnahSuccess(riquatList));
    } catch (e) {
      emit(RiquatSunnahFailure('oops something went wrong + $e'));
    }
  }
}
