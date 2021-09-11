import 'dart:convert';

class ModelAyat {
  ModelAyat({
    required this.id,
    required this.qSurah,
    required this.qVerse,
    required this.qAyat,
    required this.qIndo,
    required this.qRead,
  });

  int id;
  int qSurah;
  int qVerse;
  String qAyat;
  String qIndo;
  String qRead;

  factory ModelAyat.fromJson(Map<String, dynamic> json) => ModelAyat(
        id: json["id"] ?? 0,
        qSurah: json["qSurah"] ?? 0,
        qVerse: json["qVerse"] ?? 0,
        qAyat: json["qAyat"] ?? "",
        qIndo: json["qIndo"] ?? "",
        qRead: json["qRead"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qSurah": qSurah,
        "qVerse": qVerse,
        "qAyat": qAyat,
        "qIndo": qIndo,
        "qRead": qRead,
      };
}
