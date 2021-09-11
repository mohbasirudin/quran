import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quran/model/quran/ayat.dart';
import 'package:quran/model/quran/surat.dart';
import 'package:sqflite/sqflite.dart';

class DbQuran {
  static var _dbName = 'quran.db';
  static Database? _db;

  static Future _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    final exist = await databaseExists(path);
    if (!exist) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {}
      ByteData data = await rootBundle.load(join("assets/db", _dbName));
      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    await openDatabase(path);
    _db = await openDatabase(path);
  }

  static Future<List<ModelSurat>> surat() async {
    if (_db == null) await _init();

    try {
      List<Map<String, dynamic>> map = [];
      await _db!.transaction((txn) async => map = await txn.query("surah"));
      List<ModelSurat> data = [];
      for (var i = 0; i < map.length; i++) {
        ModelSurat model = ModelSurat.fromJson(map[i]);
        data.add(model);
      }
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<List<ModelAyat>> ayat({required var surat}) async {
    if (_db == null) await _init();

    try {
      List<Map<String, dynamic>> map = [];
      await _db!.transaction((txn) async =>
          map = await txn.query("tbQuran", where: "qSurah=$surat"));
      List<ModelAyat> data = [];
      for (var i = 0; i < map.length; i++) {
        ModelAyat model = ModelAyat.fromJson(map[i]);
        data.add(model);
      }
      return data;
    } catch (e) {
      return [];
    }
  }
}
