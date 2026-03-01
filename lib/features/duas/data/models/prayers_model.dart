class PrayersModel {
  final int index;
  final String dua;

  PrayersModel({required this.index, required this.dua});

  factory PrayersModel.fromJson(Map<String, dynamic> json) {
    return PrayersModel(index: json['index'], dua: json['dua']);
  }
}
