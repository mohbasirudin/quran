import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/api/api_url.dart';

class ControllerKota extends GetxController {
  RxList<dynamic> data = <dynamic>[].obs;
  RxBool loading = true.obs;
  ScrollController scrollController = ScrollController();
  RxDouble elevation = 0.0.obs;

  @override
  void onInit() {
    getData();

    scrollController.addListener(() {
      var cur = scrollController.position.pixels;
      var top = scrollController.position.minScrollExtent;
      if (cur > top)
        elevation.value = 2;
      else
        elevation.value = 0;
    });

    super.onInit();
  }

  void getData() async {
    loading.value = true;
    try {
      await GetConnect().get(ApiShalat.kota()).then((value) {
        data.value = value.body;
      });
      print("${data.length}");
    } catch (e) {
      print("$e");
      data.value = [];
    }
    loading.value = false;
  }
}
