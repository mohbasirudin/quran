import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quran/base/const.dart';
import 'package:quran/controller/shalat.dart';
import 'package:quran/model/shalat/monthly.dart';
import 'package:quran/view/menu/menu_kota.dart';

class PageShalat extends GetView<ControllerShalat> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.kotaName.value,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          elevation: controller.elevation.value,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () async {
                String result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => MenuKota(
                        curId: controller.kotaId,
                      ),
                    ) ??
                    "";

                if (result.isNotEmpty) {
                  var uri = Uri.parse(result);
                  controller.kotaName.value = uri.queryParameters['lokasi']!;
                  controller.kotaId = uri.queryParameters['id']!;
                  controller.getData(id: controller.kotaId);
                }
              },
              icon: Icon(
                Icons.arrow_drop_down_rounded,
              ),
            ),
          ],
        ),
        body: Container(
          child: controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.data.isEmpty
                  ? Center(
                      child: Text(
                        "Not Found",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) => _item(
                        data: controller.data[index],
                        index: index,
                      ),
                    ),
        ),
      ),
    );
  }

  _item({required Jadwal data, required int index}) {
    List<String> time = [
      data.subuh,
      data.dzuhur,
      data.ashar,
      data.maghrib,
      data.isya,
    ];
    var date = data.tanggal.split(",");
    var selected = DateFormat("yyyy-MM-dd").format(DateTime.now()) == data.date;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Colors.blue.shade700 : Colors.grey.shade100,
          width: 2,
        ),
      ),
      margin: EdgeInsets.only(
        top: index == 0 ? 16 : 8,
        bottom: index == (controller.data.length - 1) ? 16 : 8,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 48,
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: selected ? Colors.blue.shade700 : Colors.grey.shade100,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      date[0],
                      style: TextStyle(
                        fontSize: 14,
                        color: selected ? Colors.white : Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat("dd MMM yyyy").format(
                      DateTime.parse(data.date),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: selected ? Colors.white : Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              children: BaseConst.shalatInt()
                  .map(
                    (i) => _subItem(
                      shalat: BaseConst.shalat[i],
                      waktu: time[i],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subItem({
    required var shalat,
    required var waktu,
  }) {
    return Flexible(
      flex: 1,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 2),
              child: Text(
                shalat,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              waktu,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
