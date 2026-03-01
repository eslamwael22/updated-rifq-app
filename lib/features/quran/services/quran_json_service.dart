import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sakina_app/core/constants/keys.dart';

class QuranJsonService {
  static Future<List<dynamic>> loadQuranJson() async {
    final String jsonString = await rootBundle.loadString(AppKeys.quran);
    final List<dynamic> data = json.decode(jsonString);
    return data;
  }
}
