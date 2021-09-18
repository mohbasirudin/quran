import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:quran/api/api_service.dart';
import 'package:quran/api/api_url.dart';
import 'package:quran/base/const.dart';
import 'package:quran/base/func.dart';
import 'package:quran/db/db_quran.dart';
import 'package:quran/model/quran/surat.dart';
import 'package:quran/model/shalat/daily.dart';
import 'package:quran/model/shalat/kota.dart';

class ControllerMain extends GetxController {
  RxList<ModelSurat> data = <ModelSurat>[].obs;
  ScrollController scrollController = ScrollController();
  RxDouble elevation = 0.0.obs;
  RxString city = "-".obs;
  RxList<String> shalat = <String>[].obs;
  List<int> timeShalat = [];
  RxString dateNow = "-".obs;
  RxString timeTo = "-:-:-".obs;
  RxString subTime = "-".obs;
  String kotaName = "";
  String kotaId = "";

  @override
  void onInit() {
    _getData();
    _getLocation();
    scrollController.addListener(() => _onScroll());

    super.onInit();
  }

  void _onScroll() {
    var top = scrollController.position.minScrollExtent;
    var cur = scrollController.position.pixels;

    if (cur > top)
      elevation.value = 4;
    else
      elevation.value = 0;
  }

  void _getData() async {
    try {
      await DbQuran.surat().then((value) => data.value = value);
    } catch (e) {}
  }

  void _getLocation() async {
    try {
      Location location = Location();
      bool service;
      PermissionStatus permissionStatus;
      LocationData locationData;

      service = await location.serviceEnabled();
      if (!service) {
        service = await location.requestService();
        if (!service) return;
      }

      permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus != PermissionStatus.granted) return;
      }

      locationData = await location.getLocation();
      double lat = locationData.latitude!;
      double long = locationData.longitude!;

      List<geo.Placemark> placemark =
          await geo.placemarkFromCoordinates(lat, long);
      city.value = placemark[1].subAdministrativeArea!;
      _setShalat(kota: city.value);
    } catch (e) {}
  }

  int index = 0;
  void _setShalat({required String kota}) async {
    var currentCity = kota.split(" ")[index];
    await ApiService.get(
      url: ApiShalat.kota(search: currentCity),
      callback: (success, message, response) {
        if (success) {
          ModelKota kota = ModelKota.fromMap(response);
          kotaId = kota.data[0].id;
          kotaName = kota.data[0].lokasi;
          _setTime();
        } else {
          index++;
          _setShalat(kota: city.value);
        }
      },
    );

    // _setTime();
  }

  void _setTime() async {
    try {
      var date = DateTime.now();
      dateNow.value = "${date.year}/${date.month}/${date.day}";

      await ApiService.get(
        url: ApiShalat.jadwal(kota: kotaId, date: dateNow.value),
        callback: (success, message, response) {
          ModelShalatDaily daily = ModelShalatDaily.fromMap(response);
          if (shalat.isNotEmpty) shalat.clear();
          Jadwal jadwal = daily.data.jadwal;
          shalat.add(jadwal.subuh);
          shalat.add(jadwal.dzuhur);
          shalat.add(jadwal.ashar);
          shalat.add(jadwal.maghrib);
          shalat.add(jadwal.isya);

          if (timeShalat.isNotEmpty) timeShalat.clear();
          timeShalat.add(BaseFunc.timeToInt(time: shalat[0]));
          timeShalat.add(BaseFunc.timeToInt(time: shalat[1]));
          timeShalat.add(BaseFunc.timeToInt(time: shalat[2]));
          timeShalat.add(BaseFunc.timeToInt(time: shalat[3]));
          timeShalat.add(BaseFunc.timeToInt(time: shalat[4]));
        },
      );

      int time = (DateTime.now().hour * 3600) +
          (DateTime.now().minute * 60) +
          DateTime.now().second;
      int toTime = 0;

      if (time >= timeShalat[0] && time < timeShalat[1]) {
        subTime.value = BaseConst.shalat[1];
        toTime = timeShalat[1];
      } else if (time >= timeShalat[1] && time < timeShalat[2]) {
        subTime.value = BaseConst.shalat[2];

        toTime = timeShalat[2];
      } else if (time >= timeShalat[2] && time < timeShalat[3]) {
        subTime.value = BaseConst.shalat[3];
        toTime = timeShalat[3];
      } else if (time >= timeShalat[3] && time < timeShalat[4]) {
        subTime.value = BaseConst.shalat[4];
        toTime = timeShalat[4];
      } else if (time >= timeShalat[4] || time < timeShalat[0]) {
        subTime.value = BaseConst.shalat[0];
        toTime = timeShalat[0];
      } else {
        subTime.value = "-";
      }
      int timeNow = (DateTime.now().hour * 3600) +
          (DateTime.now().minute * 60) +
          DateTime.now().second;
      Timer.periodic(Duration(seconds: 1), (timer) {
        timeNow++;
        int intTime = toTime - timeNow;

        var hour = 0;
        var minute = 0;
        var second = 0;

        if (intTime >= 3600) {
          String dataTime = (intTime / 3600).toString();
          hour = int.parse(dataTime.split(".")[0]);
          intTime = intTime - (hour * 3600);
        }

        if (intTime >= 60) {
          String dataTime = (intTime / 60).toString();
          minute = int.parse(dataTime.split(".")[0]);
          intTime = intTime - (minute * 60);
        }

        second = intTime;

        timeTo.value = "$hour:$minute:$second";

        if (timeNow == toTime) {
          _setTime();
        }
      });
    } catch (e) {}
  }
}
