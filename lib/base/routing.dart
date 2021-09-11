import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/binding/ayat.dart';
import 'package:quran/binding/main.dart';
import 'package:quran/binding/shalat.dart';
import 'package:quran/binding/splash.dart';
import 'package:quran/view/page_main.dart';
import 'package:quran/view/page_splash.dart';
import 'package:quran/view/quran/page_ayat.dart';
import 'package:quran/view/shalat/page_shalat.dart';

class BaseRoute {
  static List<GetPage> pages() => [
        _getPage(
          name: PageTo.splash,
          page: PageSplash(),
          binding: BindingSplash(),
        ),
        _getPage(
          name: PageTo.main,
          page: PageMain(),
          binding: BindingMain(),
        ),
        _getPage(
          name: PageTo.ayat,
          page: PageAyat(),
          binding: BindingAyat(),
        ),
        _getPage(
          name: PageTo.ayat,
          page: PageShalat(),
          binding: BindingShalat(),
        ),
      ];

  static GetPage _getPage({
    required var name,
    required var page,
    Bindings? binding,
  }) =>
      GetPage(
        name: name,
        page: () => page,
        binding: binding ?? null,
        transition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 400),
      );
}

class PageTo {
  static const splash = "/";
  static const main = "/main";
  static const ayat = "/ayat";
  static const shalat = "/shalat";
}
