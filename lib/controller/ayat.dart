import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quran/base/send.dart';
import 'package:quran/db/db_quran.dart';
import 'package:quran/model/quran/ayat.dart';

class ControllerAyat extends GetxController {
  RxList<ModelAyat> data = <ModelAyat>[].obs;
  RxDouble elevation = 0.0.obs;
  ScrollController scrollController = ScrollController();
  RxString suratId = "".obs;
  RxString suratName = "".obs;
  RxString suratTrans = "".obs;
  RxString suratJenis = "".obs;
  RxString suratJumlah = "".obs;

  @override
  void onInit() {
    suratId.value = Get.parameters[DataSend.surat_id]!;
    suratName.value = Get.parameters[DataSend.surat_name]!;
    suratTrans.value = Get.parameters[DataSend.surat_trans]!;
    suratJenis.value = Get.parameters[DataSend.surat_jenis]!;
    suratJumlah.value = Get.parameters[DataSend.surat_jumlah]!;

    scrollController.addListener(() => _onScroll());

    _getData(surat: suratId);
    super.onInit();
  }

  void _onScroll() {
    var cur = scrollController.position.pixels;
    var top = scrollController.position.minScrollExtent;

    if (cur > top)
      elevation.value = 2;
    else
      elevation.value = 0;
  }

  void _getData({required var surat}) async {
    try {
      await DbQuran.ayat(surat: surat).then((value) => data.value = value);
    } catch (e) {
      data.value = [];
    }
  }
}
