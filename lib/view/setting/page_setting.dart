import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/base/global.dart';

class PageSetting extends StatelessWidget {
  String about = "Silahkan digunakan untuk belajar & dikembangkan"
      " lagi agar menjadi aplikasi yang lebih bagus & menarik, karna masih banyak kekurangan dalam aplikasi ini."
      "\n\nDan semoga bermanfaat aplikasinya :)";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            "Setting",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            Text(
              "Al-Quran",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 24,
                top: 4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Tampilkan latin",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Switch(
                    value: BaseGlobal.showLatin.value,
                    activeColor: Colors.blue.shade700,
                    inactiveTrackColor: Colors.grey.shade300,
                    inactiveThumbColor: Colors.grey.shade100,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) => BaseGlobal.showLatin.value = value,
                  )
                ],
              ),
            ),
            Text(
              "About",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                about,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                ),
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
