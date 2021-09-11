import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/base/assets.dart';
import 'package:quran/controller/ayat.dart';
import 'package:quran/model/quran/ayat.dart';

class PageAyat extends GetView<ControllerAyat> {
  const PageAyat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverAppBar(
            title: Text(
              controller.suratName.value,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            elevation: controller.elevation.value,
            pinned: true,
            expandedHeight: 320,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(top: 80),
                child: Container(
                  height: 240,
                  margin: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  // padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 48,
                          child: Image.asset(
                            BaseImage.surat(nomor: controller.suratId.value),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Text(
                            controller.suratTrans.value,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            "${controller.suratJenis.value} - ${controller.suratJumlah.value} Ayat",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 24,
                            bottom: 16,
                          ),
                          child: Divider(
                            endIndent: Get.width / 12,
                            indent: Get.width / 12,
                            height: 1,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          height: 40,
                          child: Image.asset(
                            BaseImage.bismillah,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _itemAyat(
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

  Widget _itemAyat({
    required List<ModelAyat> data,
    required var index,
  }) {
    double sizeNumbering = 32;
    return Material(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        margin: EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      data[index].qAyat,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      data[index].qRead,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    alignment: Alignment.topLeft,
                    child: Text(
                      data[index].qIndo,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
