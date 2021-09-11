import 'dart:convert';

ModelKota modelKotaFromMap(String str) => ModelKota.fromMap(json.decode(str));

String modelKotaToMap(ModelKota data) => json.encode(data.toMap());

class ModelKota {
  ModelKota({
    required this.status,
    required this.data,
  });

  bool status;
  List<Datum> data;

  factory ModelKota.fromMap(Map<String, dynamic> json) => ModelKota(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.lokasi,
  });

  String id;
  String lokasi;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        lokasi: json["lokasi"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "lokasi": lokasi,
      };
}
