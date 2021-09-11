import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quran/base/assets.dart';
import 'package:quran/base/const.dart';
import 'package:quran/base/routing.dart';
import 'package:quran/base/send.dart';
import 'package:quran/controller/main.dart';
import 'package:quran/model/quran/surat.dart';

class PageMain extends GetView<ControllerMain> {
  const PageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverAppBar(
            title: Text(
              "Quran App",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: controller.elevation.value,
            centerTitle: false,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Material(
              child: Container(
                margin: EdgeInsets.only(top: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Assalamu'alaikum",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 4,
                        bottom: 8,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Moh. Basirudin",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      // height: Get.width / 2,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.place,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.city.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                DateFormat("dd MMM yyyy")
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 12),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    controller.timeTo.value,
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Menuju ${controller.subTime.value}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: BaseConst.shalatInt()
                                  .map(
                                    (index) => _itemShalat(
                                      shalat: BaseConst.shalat[index],
                                      waktu: controller.shalat.isNotEmpty
                                          ? controller.shalat[index]
                                          : "-",
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            height: 40,
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => Get.toNamed(PageTo.shalat),
                              child: Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => _itemSurat(
                data: controller.data,
                index: index,
              ),
              childCount: controller.data.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemShalat({
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
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              waktu,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemSurat({
    required List<ModelSurat> data,
    required var index,
  }) {
    double sizeNumbering = 40;
    return GestureDetector(
      child: Material(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          color: (index % 2 == 1) ? Colors.grey.shade50 : Colors.white,
          child: Row(
            children: [
              Container(
                width: sizeNumbering,
                height: sizeNumbering,
                margin: EdgeInsets.only(right: 12),
                child: Stack(
                  children: [
                    Container(
                      width: sizeNumbering,
                      height: sizeNumbering,
                      child: Image.asset(
                        BaseImage.numbering,
                        color: Colors.blue.shade400,
                      ),
                    ),
                    Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade400,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 2),
                        child: Text(
                          data[index].sName,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "${data[index].sJenis} | ${data[index].sJumlah} Ayat",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 32,
                child: Image.asset(
                  BaseImage.surat(nomor: index + 1),
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => Get.toNamed(
        PageTo.ayat,
        parameters: {
          DataSend.surat_id: data[index].sId.toString(),
          DataSend.surat_name: data[index].sName,
          DataSend.surat_trans: data[index].sArti,
          DataSend.surat_jumlah: data[index].sJumlah.toString(),
          DataSend.surat_jenis: data[index].sJenis,
        },
      ),
    );
  }
}
