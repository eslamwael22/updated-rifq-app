import 'package:dartz/dartz.dart';
import 'package:sakina_app/core/error/app_error.dart';
import 'package:sakina_app/features/duas/data/models/prayers_model.dart';

abstract class DuaRepo {
  Future<Either<AppError, List<PrayersModel>>> getPrayers();
  Future<Either<AppError, List<PrayersModel>>> getFinallyDuas();
}
