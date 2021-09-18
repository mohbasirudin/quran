import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quran/api/api_service.dart';
import 'package:quran/api/api_url.dart';
import 'package:quran/base/send.dart';
import 'package:quran/model/shalat/monthly.dart';

class ControllerShalat extends GetxController {
  RxList<Jadwal> data = <Jadwal>[].obs;
  String kotaId = "";
  RxString kotaName = "".obs;
  RxBool loading = true.obs;
  RxDouble elevation = 0.0.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    kotaId = Get.parameters[DataSend.kota_id]!;
    kotaName.value = Get.parameters[DataSend.kota_name]!;

    getData(id: kotaId);

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

  void getData({required var id}) async {
    loading.value = true;
    try {
      var year = DateTime.now().year;
      var month = DateTime.now().month;
      await ApiService.get(
        url: ApiShalat.jadwal(kota: id, date: "$year/$month"),
        callback: (success, message, response) {
          if (data.isNotEmpty) data.clear();
          if (success) {
            ModelShalatMonthly shalat = ModelShalatMonthly.fromMap(response);
            data.addAll(shalat.data.jadwal);
          } else {
            data.value = [];
          }
        },
      );
    } catch (e) {
      data.value = [];
    }
    loading.value = false;
  }
}
