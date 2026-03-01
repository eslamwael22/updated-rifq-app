import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:sakina_app/core/constants/keys.dart';
import 'package:sakina_app/core/error/app_error.dart';
import 'package:sakina_app/core/error/json_error.dart';
import 'package:sakina_app/features/duas/data/models/prayers_model.dart';
import 'package:sakina_app/features/duas/data/repo/dua_repo.dart';

class DuaRepoImpl extends DuaRepo {
  List<PrayersModel> prayersListCached = [];
  @override
  Future<Either<AppError, List<PrayersModel>>> getPrayers() async {
    if (prayersListCached.isNotEmpty) {
      return Right(prayersListCached);
    }
    try {
      final duas = await rootBundle.loadString(AppKeys.duaPath);
      final List<PrayersModel> prayersList = [];

      for (var dua in jsonDecode(duas)) {
        prayersList.add(PrayersModel.fromJson(dua));
      }
      prayersListCached = prayersList;
      return Right(prayersList);
    } catch (e) {
      return Left(JsonError(errorMessage: e.toString()));
    }
  }

  List<PrayersModel> prayersListCachedFinally = [];
  @override
  Future<Either<AppError, List<PrayersModel>>> getFinallyDuas() async {
    if (prayersListCachedFinally.isNotEmpty) {
      return Right(prayersListCachedFinally);
    }
    try {
      final duas = await rootBundle.loadString(AppKeys.finallyQuranDuas);
      final List<PrayersModel> prayersList = [];

      for (var dua in jsonDecode(duas)) {
        prayersList.add(PrayersModel.fromJson(dua));
      }
      prayersListCachedFinally = prayersList;
      return Right(prayersList);
    } catch (e) {
      return Left(JsonError(errorMessage: e.toString()));
    }
  }
}
