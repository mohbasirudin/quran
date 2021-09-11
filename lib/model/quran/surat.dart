class ModelSurat {
  ModelSurat({
    required this.sId,
    required this.sName,
    required this.sArab,
    required this.sArti,
    required this.sJumlah,
    required this.sJenis,
    required this.sUrutan,
  });

  int sId;
  String sName;
  String sArab;
  String sArti;
  int sJumlah;
  String sJenis;
  String sUrutan;

  factory ModelSurat.fromJson(Map<String, dynamic> json) => ModelSurat(
        sId: json["sId"] ?? 0,
        sName: json["sName"] ?? "",
        sArab: json["sArab"] ?? "",
        sArti: json["sArti"] ?? "",
        sJumlah: json["sJumlah"] ?? 0,
        sJenis: json["sJenis"] ?? "",
        sUrutan: json["sUrutan"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "sId": sId,
        "sName": sName,
        "sArab": sArab,
        "sArti": sArti,
        "sJumlah": sJumlah,
        "sJenis": sJenis,
        "sUrutan": sUrutan,
      };
}
