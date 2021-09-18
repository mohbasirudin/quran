import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/kota.dart';

class MenuKota extends StatelessWidget {
  final curId;
  MenuKota({required this.curId});

  late ControllerKota controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(ControllerKota());
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Daftar Kota",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            elevation: controller.elevation.value,
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () => controller.getData(),
                icon: Icon(
                  Icons.sync,
                  color: Colors.black26,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.close,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
          body: Container(
            child: controller.data.isEmpty
                ? Center(
                    child: controller.loading.value
                        ? CircularProgressIndicator()
                        : Text(
                            "Not Found",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  )
                : ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) => _item(
                      data: controller.data[index],
                      index: index,
                      curId: curId,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  _item({required var data, required var curId, required var index}) {
    var id = data['id'];
    var selected = id == curId;
    return Material(
      color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data["lokasi"],
                    style: TextStyle(
                      color: selected ? Colors.blue.shade700 : Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                Icon(
                  Icons.check_circle_rounded,
                  color: selected ? Colors.blue.shade700 : Colors.grey.shade300,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        onTap: () =>
            Get.back(result: "?id=${data['id']}&&lokasi=${data['lokasi']}"),
      ),
    );
  }
}
