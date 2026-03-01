class RiquatSunnahModel {
  final String number;
  final String text;

  RiquatSunnahModel({
    required this.number,
    required this.text,
  });

  factory RiquatSunnahModel.fromJson(Map<String, dynamic> json) {
    return RiquatSunnahModel(
      number: json['number'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
    };
  }
}
